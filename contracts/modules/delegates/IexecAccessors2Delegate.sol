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

import "../DelegateBase.sol";
import "../interfaces/IexecAccessors2.sol";


contract IexecAccessorsDelegate2 is IexecAccessors2, DelegateBase
{
	function viewProxyDeal(bytes32 _id)
	external view override returns (IexecLibCore_v5.ProxyDeal memory deal)
	{
		return m_proxydeals[_id];
	}

	function viewProxyTask(bytes32 _taskid)
	external view override returns (IexecLibCore_v5.ProxyTask memory)
	{
		return m_proxytasks[_taskid];
	}

}
