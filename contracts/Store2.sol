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

import "./Store.sol";

/****************************************************************************
 * WARNING: Be carefull when editing this file.                             *
 *                                                                          *
 * If you want add new variables for expanded features, add them at the     *
 * end, or (better?) create a Store_v2 that inherits from this Store.       *
 *                                                                          *
 * If in doubt, read about ERC1538 memory store.                            *
 ****************************************************************************/

abstract contract Store2 is Store
{
	mapping(bytes32 =>                    IexecLibCore_v5.ProxyDeal         ) internal m_proxydeals;         // per deal
	mapping(bytes32 =>                    IexecLibCore_v5.ProxyTask         ) internal m_proxytasks;         // per task
}
