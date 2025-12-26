import "reflect-metadata";

import { greet } from "./test-typescript-module.ts";

@Inject("bla")
class Test {
  constructor(private value: number) {}

  sayHello() {
    return greet(this.value + " is a number");
  }
}

function Inject(param: string) {
  return function (target: Function) {
    // Decorator logic (if any) goes here
  };
}
