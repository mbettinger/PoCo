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

import "../../libs/IexecLibCore_v5.sol";

interface IexecPoco3
{
	event Reward(address owner, uint256 amount, bytes32 ref);
	event Seize (address owner, uint256 amount, bytes32 ref);
	event Lock  (address owner, uint256 amount);
	event Unlock(address owner, uint256 amount);

	event AccurateContribution(address indexed worker, bytes32 indexed taskid);
	event FaultyContribution  (address indexed worker, bytes32 indexed taskid);

	event TaskInitialize(bytes32 indexed taskid, address indexed workerpool);
	event TaskContribute(bytes32 indexed taskid, address indexed worker, bytes32 hash);
	event TaskConsensus (bytes32 indexed taskid, bytes32 consensus);
	event TaskReveal    (bytes32 indexed taskid, address indexed worker, bytes32 digest);
	event TaskFinalize  (bytes32 indexed taskid, bytes results);
	event TaskClaimed   (bytes32 indexed taskid);
	event TaskReopen    (bytes32 indexed taskid);

	function proxyInitContribAndFinalize(IexecLibCore_v5.ProxyDeal memory, IexecLibCore_v5.ProxyTask memory, address, bytes memory, bytes memory) external; // Expansion - result separation
}
