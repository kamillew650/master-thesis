import http from "k6/http";
import { sleep } from "k6";

export const options = {
  stages: [
    { duration: "10s", target: 100 }, // simulate ramp-up of traffic from 1 to 100 users over 5 minutes.
    { duration: "30s", target: 100 }, // stay at 100 users for 10 minutes
    { duration: "5s", target: 0 }, // ramp-down to 0 users
  ],
};

export default function () {
  http.get(`${__ENV.SERVICE_URL}/simple-response`);
  sleep(1);
}
