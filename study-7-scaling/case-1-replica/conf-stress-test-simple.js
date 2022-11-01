import http from "k6/http";
import { sleep } from "k6";

export const options = {
  stages: [
    { duration: "10s", target: 100 },
    { duration: "30s", target: 100 },
    { duration: "10s", target: 200 },
    { duration: "30s", target: 200 },
    { duration: "10s", target: 300 },
    { duration: "30s", target: 300 },
    { duration: "10s", target: 400 },
    { duration: "30s", target: 400 },
    { duration: "10s", target: 0 },
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
