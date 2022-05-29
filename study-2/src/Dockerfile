FROM nginx:stable

ARG PORT=81

EXPOSE ${PORT}

STOPSIGNAL SIGQUIT

CMD ["nginx", "-g", "daemon"];

ADD file:134f25aec8adf83cb940ba073a3409ca85dbb5ae592b704f95193e7d2539a3bc in / 

CMD ["bash"]

