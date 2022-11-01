import http from "k6/http";
import { sleep } from "k6";

export const options = {
  vus: parseInt(__ENV.VUS),
  duration: "30s",
};

export default function () {
  http.get(
    `${__ENV.SERVICE_URL}/calculation?from=${__ENV.TIME_FROM}&to=${__ENV.TIME_TO}`
  );
  sleep(1);
}
