pragma solidity ^0.6.0;
pragma experimental ABIEncoderV2;

import "../contracts/libs/IexecLibCore_v5.sol";

contract Impersonator
{
	function viewDeal(bytes32 _dealid) pure public returns (IexecLibCore_v5.ProxyDeal memory){
	    bytes memory callback=abi.encode(uint256(1631029502),string("BTC-USD-9-2021-09-06"),int256(52668621800000));
        bytes32 resultsDigest=keccak256(callback);
	    return IexecLibCore_v5.ProxyDeal(133,
            address(0x3eca1B216A7DF1C7689aEb259fFB83ADFB894E7f),
            address(0x41A7aCC46CcE7fc7988156baE7193b77AAB1AE54),
            address(0x7d6847b9fBD4Cb66DC9aA75bAB350709C8182f38),
            IexecLibCore_v5.Resource(address(0x2B6f9348b2379e231910dF16915Df3a356e6eFff),
                    address(0x7d6847b9fBD4Cb66DC9aA75bAB350709C8182f38),
                    1),
            1,
            bytes32(0x0000000000000000000000000000000000000000000000000000000000000001),
            address(0x01)
            );
	}
	
	function viewTask(bytes32 _taskid) pure public returns (IexecLibCore_v5.ProxyTask memory){
	    bytes memory callback=abi.encode(uint256(1631029502),string("BTC-USD-9-2021-09-06"),int256(52668621800000));
        bytes32 resultsDigest=keccak256(callback);
	    return IexecLibCore_v5.ProxyTask(bytes32(0x6aa5b7cb91a8ebc62041eb8be82eb273cbe8a0f48a4c60b7f181760b8f2417a3),
                		1,
                		bytes32(resultsDigest),
                		bytes("{\"storage\":\"ipfs\",\"location\":\"/ipfs/QmRjxRrFkgtB8sM7e4b8ZKqLXiK8NWhpnQLkn1bGii2NWE\"}"),
                		callback);
	}
}
