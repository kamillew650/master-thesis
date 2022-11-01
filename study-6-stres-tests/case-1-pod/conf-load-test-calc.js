import http from "k6/http";
import { sleep } from "k6";

export const options = {
  stages: [
    { duration: "10s", target: 100 },
    { duration: "30s", target: 100 },
    { duration: "5s", target: 0 },
  ],
};

export default function () {
  http.batch([
    {
      method: "GET",
      url: `${__ENV.SERVICE_URL}/calculation?from=${__ENV.TIME_FROM}&to=${__ENV.TIME_TO}`,
    },
    {
      method: "GET",
      url: `${__ENV.SERVICE_URL}/calculation?from=${__ENV.TIME_FROM}&to=${__ENV.TIME_TO}`,
    },
    {
      method: "GET",
      url: `${__ENV.SERVICE_URL}/calculation?from=${__ENV.TIME_FROM}&to=${__ENV.TIME_TO}`,
    },
    {
      method: "GET",
      url: `${__ENV.SERVICE_URL}/calculation?from=${__ENV.TIME_FROM}&to=${__ENV.TIME_TO}`,
    },
  ]);
  sleep(1);
}
