import http from "k6/http";
import { sleep } from "k6";

export const options = {
  vus: 2,
  duration: "30s",
};

export default function () {
  http.get(`${__ENV.SERVICE_URL}/simple-response`);
  sleep(1);
}
