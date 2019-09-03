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

export class CreateApp extends EthereumEvent {
  get params(): CreateApp__Params {
    return new CreateApp__Params(this);
  }
}

export class CreateApp__Params {
  _event: CreateApp;

  constructor(event: CreateApp) {
    this._event = event;
  }

  get appOwner(): Address {
    return this._event.parameters[0].value.toAddress();
  }

  get app(): Address {
    return this._event.parameters[1].value.toAddress();
  }
}

export class AppRegistry extends SmartContract {
  static bind(address: Address): AppRegistry {
    return new AppRegistry("AppRegistry", address);
  }

  viewEntry(_owner: Address, _index: BigInt): Address {
    let result = super.call("viewEntry", [
      EthereumValue.fromAddress(_owner),
      EthereumValue.fromUnsignedBigInt(_index)
    ]);
    return result[0].toAddress();
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

  createApp(
    _appOwner: Address,
    _appName: string,
    _appType: string,
    _appMultiaddr: Bytes,
    _appChecksum: Bytes,
    _appMREnclave: Bytes
  ): Address {
    let result = super.call("createApp", [
      EthereumValue.fromAddress(_appOwner),
      EthereumValue.fromString(_appName),
      EthereumValue.fromString(_appType),
      EthereumValue.fromBytes(_appMultiaddr),
      EthereumValue.fromFixedBytes(_appChecksum),
      EthereumValue.fromBytes(_appMREnclave)
    ]);
    return result[0].toAddress();
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
}

export class ConstructorCall__Outputs {
  _call: ConstructorCall;

  constructor(call: ConstructorCall) {
    this._call = call;
  }
}

export class CreateAppCall extends EthereumCall {
  get inputs(): CreateAppCall__Inputs {
    return new CreateAppCall__Inputs(this);
  }

  get outputs(): CreateAppCall__Outputs {
    return new CreateAppCall__Outputs(this);
  }
}

export class CreateAppCall__Inputs {
  _call: CreateAppCall;

  constructor(call: CreateAppCall) {
    this._call = call;
  }

  get _appOwner(): Address {
    return this._call.inputValues[0].value.toAddress();
  }

  get _appName(): string {
    return this._call.inputValues[1].value.toString();
  }

  get _appType(): string {
    return this._call.inputValues[2].value.toString();
  }

  get _appMultiaddr(): Bytes {
    return this._call.inputValues[3].value.toBytes();
  }

  get _appChecksum(): Bytes {
    return this._call.inputValues[4].value.toBytes();
  }

  get _appMREnclave(): Bytes {
    return this._call.inputValues[5].value.toBytes();
  }
}

export class CreateAppCall__Outputs {
  _call: CreateAppCall;

  constructor(call: CreateAppCall) {
    this._call = call;
  }

  get value0(): Address {
    return this._call.outputValues[0].value.toAddress();
  }
}
