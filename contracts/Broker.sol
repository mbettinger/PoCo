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
		IexecODBLibOrders.DappOrder _dapporder,
		IexecODBLibOrders.DataOrder _dataorder,
		IexecODBLibOrders.PoolOrder _poolorder,
		IexecODBLibOrders.UserOrder _userorder)
	public returns (bytes32)
	{
		uint256 gasBefore = gasleft();

		bytes32 dealid = iexecclerk.matchOrders(
			_dapporder,
			_dataorder,
			_poolorder,
			_userorder);

		address payer = Pool(_poolorder.pool).m_owner();
		uint256 price = m_preferences[payer].reward + tx.gasprice.min(m_preferences[payer].maxgasprice) * (87000 + gasBefore - gasleft());
		m_balance[payer] = m_balance[payer].sub(price);
		msg.sender.transfer(price);

		return dealid;
	}

	function matchOrdersForUser(
		IexecODBLibOrders.DappOrder _dapporder,
		IexecODBLibOrders.DataOrder _dataorder,
		IexecODBLibOrders.PoolOrder _poolorder,
		IexecODBLibOrders.UserOrder _userorder)
	public returns (bytes32)
	{
		uint256 gasBefore = gasleft();

		bytes32 dealid = iexecclerk.matchOrders(
			_dapporder,
			_dataorder,
			_poolorder,
			_userorder);

		address payer = _userorder.requester;
		uint256 price = m_preferences[payer].reward + tx.gasprice.min(m_preferences[payer].maxgasprice) * (87000 + gasBefore - gasleft());
		m_balance[payer] = m_balance[payer].sub(price);
		msg.sender.transfer(price);

		return dealid;
	}


}