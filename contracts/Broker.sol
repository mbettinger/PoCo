pragma solidity ^0.4.25;
pragma experimental ABIEncoderV2;

import "./libs/IexecODBLibOrders.sol";
import "./libs/SafeMathOZ.sol";

import "./IexecClerk.sol";

contract Broker
{
	using SafeMathOZ for uint256;

	struct Preferences
	{
		uint reward;
		uint maxgasprice;
	}

	IexecClerk                      public iexecclerk;
	mapping(address => uint256    ) public m_balance;
	mapping(address => Preferences) public m_preferences;

	constructor(address _iexecclerk)
	public
	{
		iexecclerk = IexecClerk(_iexecclerk);
	}

	function ()
	public payable
	{
		m_balance[msg.sender] = m_balance[msg.sender].add(msg.value);
	}

	function deposit()
	public payable
	{
		m_balance[msg.sender] = m_balance[msg.sender].add(msg.value);
	}

	function depositFor(address _account)
	public payable
	{
		m_balance[_account] = m_balance[_account].add(msg.value);
	}

	function withdraw(uint256 _amount)
	public
	{
		m_balance[msg.sender] = m_balance[msg.sender].sub(_amount);
		msg.sender.transfer(_amount);
	}

	function setPreferences(uint256 _reward, uint256 _maxgasprice)
	public
	{
		m_preferences[msg.sender].reward      = _reward;
		m_preferences[msg.sender].maxgasprice = _maxgasprice;
	}

	function matchOrdersForPool(
		IexecODBLibOrders.AppOrder        _apporder,
		IexecODBLibOrders.DatasetOrder    _datasetorder,
		IexecODBLibOrders.WorkerpoolOrder _workerpoolorder,
		IexecODBLibOrders.RequestOrder    _requestorder)
	public returns (bytes32)
	{
		uint256 gasBefore = gasleft();

		bytes32 dealid = iexecclerk.matchOrders(
			_apporder,
			_datasetorder,
			_workerpoolorder,
			_requestorder);

		address payer = Workerpool(_workerpoolorder.workerpool).m_owner();
		uint256 price = m_preferences[payer].reward + tx.gasprice.min(m_preferences[payer].maxgasprice) * (87000 + gasBefore - gasleft());
		m_balance[payer] = m_balance[payer].sub(price);
		msg.sender.transfer(price);

		return dealid;
	}

	function matchOrdersForRequester(
		IexecODBLibOrders.AppOrder        _apporder,
		IexecODBLibOrders.DatasetOrder    _datasetorder,
		IexecODBLibOrders.WorkerpoolOrder _workerpoolorder,
		IexecODBLibOrders.RequestOrder    _requestorder)
	public returns (bytes32)
	{
		uint256 gasBefore = gasleft();

		bytes32 dealid = iexecclerk.matchOrders(
			_apporder,
			_datasetorder,
			_workerpoolorder,
			_requestorder);

		address payer = _requestorder.requester;
		uint256 price = m_preferences[payer].reward + tx.gasprice.min(m_preferences[payer].maxgasprice) * (87000 + gasBefore - gasleft());
		m_balance[payer] = m_balance[payer].sub(price);
		msg.sender.transfer(price);

		return dealid;
	}


}
