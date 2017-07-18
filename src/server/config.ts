import * as fs from "fs";

export class Bind {
  host: string;
  port: number;

  toString(): string {
    return `${this.host}:${this.port}`;
  }
}

export class Config {
  bind: Bind;
}

const config = JSON.parse(fs.readFileSync("config.json", "utf8")) as Config;
export default config;
