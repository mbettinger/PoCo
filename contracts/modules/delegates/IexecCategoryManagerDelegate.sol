pragma solidity ^0.6.0;
pragma experimental ABIEncoderV2;

import "../DelegateBase.sol";
import "../interfaces/IexecCategoryManager.sol";


contract IexecCategoryManagerDelegate is IexecCategoryManager, DelegateBase
{
	/**
	 * Methods
	 */
	function createCategory(
		string  calldata name,
		string  calldata description,
		uint256          workClockTimeRef)
	external override onlyOwner returns (uint256)
	{
		uint256 catid = m_categories.push(IexecLibCore_v4.Category(
			name,
			description,
			workClockTimeRef
		)) - 1;

		emit CreateCategory(
			catid,
			name,
			description,
			workClockTimeRef
		);
		return catid;
	}
}
