// THIS IS AN AUTOGENERATED FILE. DO NOT EDIT THIS FILE DIRECTLY.

import {
  EthereumCall,
  EthereumEvent,
  SmartContract,
  EthereumValue,
  JSONValue,
  TypedMap,
  Entity,
  EthereumTuple,
  Bytes,
  Address,
  BigInt
} from "@graphprotocol/graph-ts";

export class CreateDataset extends EthereumEvent {
  get params(): CreateDataset__Params {
    return new CreateDataset__Params(this);
  }
}

export class CreateDataset__Params {
  _event: CreateDataset;

  constructor(event: CreateDataset) {
    this._event = event;
  }

  get datasetOwner(): Address {
    return this._event.parameters[0].value.toAddress();
  }

  get dataset(): Address {
    return this._event.parameters[1].value.toAddress();
  }
}

export class OwnershipTransferred extends EthereumEvent {
  get params(): OwnershipTransferred__Params {
    return new OwnershipTransferred__Params(this);
  }
}

export class OwnershipTransferred__Params {
  _event: OwnershipTransferred;

  constructor(event: OwnershipTransferred) {
    this._event = event;
  }

  get previousOwner(): Address {
    return this._event.parameters[0].value.toAddress();
  }

  get newOwner(): Address {
    return this._event.parameters[1].value.toAddress();
  }
}

export class DatasetRegistry extends SmartContract {
  static bind(address: Address): DatasetRegistry {
    return new DatasetRegistry("DatasetRegistry", address);
  }

  viewEntry(_owner: Address, _index: BigInt): Address {
    let result = super.call("viewEntry", [
      EthereumValue.fromAddress(_owner),
      EthereumValue.fromUnsignedBigInt(_index)
    ]);
    return result[0].toAddress();
  }

  m_previous(): Address {
    let result = super.call("m_previous", []);
    return result[0].toAddress();
  }

  owner(): Address {
    let result = super.call("owner", []);
    return result[0].toAddress();
  }

  isOwner(): boolean {
    let result = super.call("isOwner", []);
    return result[0].toBoolean();
  }

  viewCount(_owner: Address): BigInt {
    let result = super.call("viewCount", [EthereumValue.fromAddress(_owner)]);
    return result[0].toBigInt();
  }

  isRegistered(_entry: Address): boolean {
    let result = super.call("isRegistered", [
      EthereumValue.fromAddress(_entry)
    ]);
    return result[0].toBoolean();
  }

  createDataset(
    _datasetOwner: Address,
    _datasetName: string,
    _datasetMultiaddr: Bytes,
    _datasetChecksum: Bytes
  ): Address {
    let result = super.call("createDataset", [
      EthereumValue.fromAddress(_datasetOwner),
      EthereumValue.fromString(_datasetName),
      EthereumValue.fromBytes(_datasetMultiaddr),
      EthereumValue.fromFixedBytes(_datasetChecksum)
    ]);
    return result[0].toAddress();
  }
}

export class RegisterENSCall extends EthereumCall {
  get inputs(): RegisterENSCall__Inputs {
    return new RegisterENSCall__Inputs(this);
  }

  get outputs(): RegisterENSCall__Outputs {
    return new RegisterENSCall__Outputs(this);
  }
}

export class RegisterENSCall__Inputs {
  _call: RegisterENSCall;

  constructor(call: RegisterENSCall) {
    this._call = call;
  }

  get ens(): Address {
    return this._call.inputValues[0].value.toAddress();
  }

  get name(): string {
    return this._call.inputValues[1].value.toString();
  }
}

export class RegisterENSCall__Outputs {
  _call: RegisterENSCall;

  constructor(call: RegisterENSCall) {
    this._call = call;
  }
}

export class RenounceOwnershipCall extends EthereumCall {
  get inputs(): RenounceOwnershipCall__Inputs {
    return new RenounceOwnershipCall__Inputs(this);
  }

  get outputs(): RenounceOwnershipCall__Outputs {
    return new RenounceOwnershipCall__Outputs(this);
  }
}

export class RenounceOwnershipCall__Inputs {
  _call: RenounceOwnershipCall;

  constructor(call: RenounceOwnershipCall) {
    this._call = call;
  }
}

export class RenounceOwnershipCall__Outputs {
  _call: RenounceOwnershipCall;

  constructor(call: RenounceOwnershipCall) {
    this._call = call;
  }
}

export class TransferOwnershipCall extends EthereumCall {
  get inputs(): TransferOwnershipCall__Inputs {
    return new TransferOwnershipCall__Inputs(this);
  }

  get outputs(): TransferOwnershipCall__Outputs {
    return new TransferOwnershipCall__Outputs(this);
  }
}

export class TransferOwnershipCall__Inputs {
  _call: TransferOwnershipCall;

  constructor(call: TransferOwnershipCall) {
    this._call = call;
  }

  get newOwner(): Address {
    return this._call.inputValues[0].value.toAddress();
  }
}

export class TransferOwnershipCall__Outputs {
  _call: TransferOwnershipCall;

  constructor(call: TransferOwnershipCall) {
    this._call = call;
  }
}

export class ConstructorCall extends EthereumCall {
  get inputs(): ConstructorCall__Inputs {
    return new ConstructorCall__Inputs(this);
  }

  get outputs(): ConstructorCall__Outputs {
    return new ConstructorCall__Outputs(this);
  }
}

export class ConstructorCall__Inputs {
  _call: ConstructorCall;

  constructor(call: ConstructorCall) {
    this._call = call;
  }

  get _previous(): Address {
    return this._call.inputValues[0].value.toAddress();
  }
}

export class ConstructorCall__Outputs {
  _call: ConstructorCall;

  constructor(call: ConstructorCall) {
    this._call = call;
  }
}

export class CreateDatasetCall extends EthereumCall {
  get inputs(): CreateDatasetCall__Inputs {
    return new CreateDatasetCall__Inputs(this);
  }

  get outputs(): CreateDatasetCall__Outputs {
    return new CreateDatasetCall__Outputs(this);
  }
}

export class CreateDatasetCall__Inputs {
  _call: CreateDatasetCall;

  constructor(call: CreateDatasetCall) {
    this._call = call;
  }

  get _datasetOwner(): Address {
    return this._call.inputValues[0].value.toAddress();
  }

  get _datasetName(): string {
    return this._call.inputValues[1].value.toString();
  }

  get _datasetMultiaddr(): Bytes {
    return this._call.inputValues[2].value.toBytes();
  }

  get _datasetChecksum(): Bytes {
    return this._call.inputValues[3].value.toBytes();
  }
}

export class CreateDatasetCall__Outputs {
  _call: CreateDatasetCall;

  constructor(call: CreateDatasetCall) {
    this._call = call;
  }

  get value0(): Address {
    return this._call.outputValues[0].value.toAddress();
  }
}