import http from "k6/http";
import { sleep } from "k6";

export const options = {
  stages: [
    { duration: "10s", target: 100 }, // below normal load
    { duration: "30s", target: 100 },
    { duration: "10s", target: 200 }, // normal load
    { duration: "30s", target: 200 },
    { duration: "10s", target: 300 }, // around the breaking point
    { duration: "30s", target: 300 },
    { duration: "10s", target: 400 }, // beyond the breaking point
    { duration: "30s", target: 400 },
    { duration: "10s", target: 0 }, // scale down. Recovery stage.
  ],
};

export default function () {
  http.batch([
    { method: "GET", url: `${__ENV.SERVICE_URL}/simple-response` },
    { method: "GET", url: `${__ENV.SERVICE_URL}/simple-response` },
    { method: "GET", url: `${__ENV.SERVICE_URL}/simple-response` },
    { method: "GET", url: `${__ENV.SERVICE_URL}/simple-response` },
  ]);
  sleep(1);
}
