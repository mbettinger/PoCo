// SPDX-License-Identifier: Apache-2.0

/******************************************************************************
 * Copyright 2020 IEXEC BLOCKCHAIN TECH                                       *
 *                                                                            *
 * Licensed under the Apache License, Version 2.0 (the "License");            *
 * you may not use this file except in compliance with the License.           *
 * You may obtain a copy of the License at                                    *
 *                                                                            *
 *     http://www.apache.org/licenses/LICENSE-2.0                             *
 *                                                                            *
 * Unless required by applicable law or agreed to in writing, software        *
 * distributed under the License is distributed on an "AS IS" BASIS,          *
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.   *
 * See the License for the specific language governing permissions and        *
 * limitations under the License.                                             *
 ******************************************************************************/

pragma solidity ^0.6.0;
pragma experimental ABIEncoderV2;

import "@iexec/solidity/contracts/ERC1154/IERC1154.sol";
import "./IexecERC20Core.sol";
import "./SignatureVerifier.sol";
import "../DelegateBase.sol";
import "../interfaces/IexecPoco3.sol";


contract IexecPoco3Delegate is IexecPoco3, DelegateBase, IexecERC20Core, SignatureVerifier
{
	function proxyInitContribAndFinalize(
	    IexecLibCore_v5.ProxyDeal memory _inDeal,
		IexecLibCore_v5.ProxyTask memory _inTask,
		address      _enclaveChallenge,
		bytes memory _enclaveSign,
		bytes memory _authorizationSign)
	override external
	{
		require(_isAuthorized(_msgSender()));
		
		// Retrieve or generate container objects for ProxyDeal/Task and Contribution
		bytes32 taskid=keccak256(abi.encodePacked(_inTask.dealid, _inTask.idx));
		IexecLibCore_v5.ProxyTask         storage stoTask         = m_proxytasks[taskid];
		IexecLibCore_v5.Contribution storage contribution = m_contributions[taskid][_msgSender()];
		IexecLibCore_v5.ProxyDeal         storage  stoDeal         = m_proxydeals[_inTask.dealid];
		
		// Verify that there is no overwrite
		require(stoTask.status==IexecLibCore_v5.TaskStatusEnum.UNSET, "Proxy task already exists");
		// Proxy Sanity checks
		require(_inTask.status==IexecLibCore_v5.TaskStatusEnum.ACTIVE);
		
		bytes32 resultHash = keccak256(abi.encodePacked(              taskid, _inTask.resultDigest));
		bytes32 resultSeal = keccak256(abi.encodePacked(_msgSender(), taskid, _inTask.resultDigest));

		//require((deal.callback == address(0) && _resultsCallback.length == 0) || keccak256(_resultsCallback) == task.resultDigest);

		// need enclave challenge if tag is set
		require(_enclaveChallenge != address(0) || (_inDeal.tag[31] & 0x01 == 0));

		// Check that the worker + taskid + enclave combo is authorized to contribute (scheduler signature)
		require(_checkSignature(
			( _enclaveChallenge != address(0) && m_teebroker != address(0) ) ? m_teebroker : _inDeal.workerpool.owner,
			_toEthSignedMessage(keccak256(abi.encodePacked(
				_msgSender(),
				taskid,
				_enclaveChallenge
			))),
			_authorizationSign
		));

		// Check enclave signature
		require(_enclaveChallenge == address(0) || _checkSignature(
			_enclaveChallenge,
			_toEthSignedMessage(keccak256(abi.encodePacked(
				resultHash,
				resultSeal
			))),
			_enclaveSign
		));
		
		// Proxy Storage
		contribution.status           = IexecLibCore_v5.ContributionStatusEnum.PROVED;
		contribution.resultHash       = resultHash;
		contribution.resultSeal       = resultSeal;
		contribution.enclaveChallenge = _enclaveChallenge;

		stoTask.status                   = IexecLibCore_v5.TaskStatusEnum.COMPLETED;
		stoTask.consensusValue           = contribution.resultHash;
		//task.revealDeadline           = task.timeref.mul(REVEAL_DEADLINE_RATIO).add(now);
		//task.revealCounter            = 1;
		//task.winnerCounter            = 1;
		stoTask.resultDigest             = _inTask.resultDigest;
		stoTask.results                  = _inTask.results;
		stoTask.resultsCallback          = _inTask.resultsCallback; // Expansion - result separation
		stoTask.contributors.push(_msgSender());
		
		stoDeal.chain=_inDeal.chain;
	    stoDeal.sourceHub=_inDeal.sourceHub;
		stoDeal.app=_inDeal.app;
		stoDeal.dataset=_inDeal.dataset;
		stoDeal.workerpool=_inDeal.workerpool;
		stoDeal.trust=_inDeal.trust;
		stoDeal.tag=_inDeal.tag;
		
		// Events
	}
}