// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.6.0;
import "remix_tests.sol"; // this import is automatically injected by Remix.
import "../contracts/Store2.sol";
import "../contracts/modules/delegates/IexecPoco3Delegate.sol";
pragma experimental ABIEncoderV2;
contract BallotTest {
   
    bytes32[] proposalNames;
    IexecPoco3Delegate deleg;
    
    function beforeAll () public {
        proposalNames.push(bytes32("candidate1"));
        deleg = new IexecPoco3Delegate();
    }
    
    function checkWinningProposal (address callback_addr) public {
        address[] memory contributors;
        bytes memory callback=abi.encode(uint256(1631029502),"BTC-USD-9-2021-09-06",int256(52668621800000));
        bytes32 resultsDigest=keccak256(callback);
        IexecLibCore_v5.ProxyDeal memory _inDeal=IexecLibCore_v5.ProxyDeal(133,
                                                                                address(0x3eca1B216A7DF1C7689aEb259fFB83ADFB894E7f),
                                                                                address(0x41A7aCC46CcE7fc7988156baE7193b77AAB1AE54),
                                                                                address(0x7d6847b9fBD4Cb66DC9aA75bAB350709C8182f38),
                                                                                IexecLibCore_v5.Resource(address(0x2B6f9348b2379e231910dF16915Df3a356e6eFff),
                                                                                        address(0x7d6847b9fBD4Cb66DC9aA75bAB350709C8182f38),
                                                                                        1),
                                                                                1,
                                                                                bytes32(0x0000000000000000000000000000000000000000000000000000000000000001),
                                                                                address(callback_addr)
                                                                                );
		IexecLibCore_v5.ProxyTask memory _inTask=IexecLibCore_v5.ProxyTask(bytes32(0x6aa5b7cb91a8ebc62041eb8be82eb273cbe8a0f48a4c60b7f181760b8f2417a3),
                                                                    		1,
                                                                    		bytes32(resultsDigest),
                                                                    		bytes("{\"storage\":\"ipfs\",\"location\":\"/ipfs/QmRjxRrFkgtB8sM7e4b8ZKqLXiK8NWhpnQLkn1bGii2NWE\"}"),
                                                                    		callback);
		address      _enclaveChallenge=address(0x7d6847b9fBD4Cb66DC9aA75bAB350709C8182f38);
		bytes memory _enclaveSign=bytes("0x8fa6e07f6cefdbac5795698f5a1c5664c8bb80b1a4561f1f40cdaed6724380955ce126bbc555a4c3cb7236dceb3c36cfede5f8217401309106ca523abc8b43ff1c");
		bytes memory _authorizationSign=bytes("0x7aac52359c11a756182111436b99b7f4252a3afdd68fc9bc0bf3d8617c175b1b1aeac5dc279748d696c36251f660dc992d3ffb8a6db662d3e9cdd3a6f7d3e9501b");
        deleg.proxyInitContribAndFinalize(_inDeal,_inTask,_enclaveChallenge,_enclaveSign,_authorizationSign);
    }

    function checkWinninProposalWithReturnValue () public view returns (bool) {
        return true;
    }
}
