import http from "k6/http";
import { sleep } from "k6";

export const options = {
  stages: [
    { duration: "10s", target: 100 },
    { duration: "40s", target: 100 },
    { duration: "5s", target: 0 },
  ],
};

export default function () {
  http.get(`${__ENV.SERVICE_URL}/simple-response`);
  sleep(1);
}
