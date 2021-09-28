// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.6.0;
import "remix_tests.sol"; // this import is automatically injected by Remix.
import "../contracts/libs/IexecLibCore_v5.sol";
import "./Impersonator.sol";
import "./PriceOracle.sol";
import "../contracts/registries/workerpools/WorkerpoolRegistry.sol";
pragma experimental ABIEncoderV2;

contract BallotTest {
   
    address _authorizedApp=address(0x41A7aCC46CcE7fc7988156baE7193b77AAB1AE54);
	address _authorizedDataset=address(0x7d6847b9fBD4Cb66DC9aA75bAB350709C8182f38);
	//address _authorizedWorkerpool;
	bytes32 _requiredtag=bytes32(0x0000000000000000000000000000000000000000000000000000000000000001);
	uint256 _requiredtrust=1;
   
    Impersonator public deleg;
    PriceOracle public oracle;
    WorkerpoolRegistry public wr;
    Workerpool public wpool;
    IexecLibCore_v5.Resource public wpsrc;
    event CreatedContract(string name, address contractAddr);
    
    constructor () public {
        deleg = new Impersonator();
        emit CreatedContract("Impersonator",address(deleg));
        oracle = new PriceOracle(address(deleg));
        emit CreatedContract("PriceOracle",address(oracle));
        wr= new WorkerpoolRegistry();
        emit CreatedContract("WorkerpoolRegistry",address(wr));
        wpool = wr.createWorkerpool(address(0xBF1992A8eC6eb1d4538e89970d2b4A87a2bA2Fa1),"my-workerpool");
        emit CreatedContract("Workerpool",address(wpool));
        deleg.changeRegistries(address(0x0), address(0x0), address(wr));
        wpsrc=IexecLibCore_v5.Resource(address(wpool),wpool.owner(),1);
        oracle.updateEnv(_authorizedApp,_authorizedDataset,wpsrc.pointer,_requiredtag,_requiredtrust);
    }
    
    function publishProxyTaskAndDeal () public {
        address[] memory contributors;
        bytes memory callback=bytes("");
        //bytes memory callback=abi.encode(uint256(1631029502),"BTC-USD-9-2021-09-06",int256(52668621800000));
        bytes32 resultsDigest=bytes32(0x2a88cdacae8432963751f6b597a19a40f8edde5fe5ad5380b38f9f63d6b44eec);
        IexecLibCore_v5.ProxyDeal memory _inDeal=IexecLibCore_v5.ProxyDeal(133,
                                                                                address(0x3eca1B216A7DF1C7689aEb259fFB83ADFB894E7f),
                                                                                _authorizedApp,
                                                                                _authorizedDataset,
                                                                                wpsrc,
                                                                                _requiredtrust,
                                                                                _requiredtag,
                                                                                //address(oracle)
                                                                                address(0x00)
                                                                                );
		IexecLibCore_v5.ProxyTask memory _inTask=IexecLibCore_v5.ProxyTask(bytes32(0x2b5b74662e37114e898753c7772fc795cbaaad20ddb0f7b3d54e995651d9736b),
                                                                    		0,
                                                                    		bytes32(resultsDigest),
                                                                    		bytes("{\"storage\":\"ipfs\",\"location\":\"/ipfs/QmRjxRrFkgtB8sM7e4b8ZKqLXiK8NWhpnQLkn1bGii2NWE\"}"),
                                                                    		bytes(callback));
		address      _enclaveChallenge=address(0x07Bf5b212392b3957218be8bc00675c0C588698B);
		bytes memory _enclaveSign=bytes(hex"b21af316bc8a94731fcb9cb077a81f40b700b890d32ac405ee50f3194c54c3c772a334f4243da4fd48896d05225541682f4d8a3cad07fcad3319728d711b27431b");
		bytes memory _authorizationSign=bytes(hex"a2446fa42be47a494fd8e75c53913aa87b30d3a96739cb47a0663751329c8c4a011b88cde3aa3fceece8950df88d33756f8cb4285d47c70e8e59c1cc4cda06371c");
        deleg.proxyInitContribAndFinalize(address(0x7a8a24d44fB456F53FD956349ac02AAB0f849016),_inDeal,_inTask,_enclaveChallenge,_enclaveSign,_authorizationSign);
    }

}
