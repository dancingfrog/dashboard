#### START docker.io/coriverse/shinyapps:dashboard
## Docker install
## coriverse/shinyapps:base is built on realcurrents/amzn-mro-3.5.1:origin
#FROM docker.io/coriverse/shinyapps:base as install
#
#ARG gh_token
#ENV GITHUB_TOKEN=$gh_token
#ARG gh_token
#ENV GITHUB_PAT=$gh_token
#ENV LD_LIBRARY_PATH /var/task/lib64:/var/task/lib:/usr/local/lib64:/usr/local/lib:/usr/lib64
#ENV PATH /var/task/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
#ENV REXEC Rscript
#
#WORKDIR /data
#
#COPY data/* ./data/
#COPY deploy.R deploy.R
#COPY .exec-shiny-app.R .exec-shiny-app.R
#COPY package.csv package.csv
#COPY packrat/lib/x86_64-pc-linux-gnu/3.5.1 ./packrat/lib/x86_64-pc-linux-gnu/3.5.1/
#COPY packrat/src ./packrat/src/
#COPY packrat/init.R ./packrat/init.R
#COPY packrat/packrat.lock ./packrat/packrat.lock
#COPY packrat/packrat.opts ./packrat/packrat.opts
#
#RUN Rscript .exec-shiny-app.R install
#### FINISH docker.io/coriverse/shinyapps:dashboard

## Pass the above resulting image to the deploy step ...
## Docker deploy
#FROM docker.io/coriverse/shinyapps:base as deploy
#COPY --from=install /var/task /var/task
#COPY --from=install /data /data

# ... or ...

# ... use a previously uploaded build of the above image
# Docker deploy (via GitHub)
FROM docker.io/coriverse/shinyapps:dashboard as deploy

ARG gh_token
ENV GITHUB_TOKEN=$gh_token
ARG gh_token
ENV GITHUB_PAT=$gh_token
ENV LD_LIBRARY_PATH /var/task/lib64:/var/task/lib:/usr/local/lib64:/usr/local/lib:/usr/lib64
ENV PATH /var/task/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
ENV REXEC Rscript

WORKDIR /data

COPY deploy.R deploy.R
COPY .exec-shiny-app.R .exec-shiny-app.R
COPY package.csv package.csv
COPY packrat/src ./packrat/src/
COPY packrat/init.R ./packrat/init.R
COPY packrat/packrat.lock ./packrat/packrat.lock
COPY packrat/packrat.opts ./packrat/packrat.opts

COPY global.R global.R
#COPY library.R library.R
#COPY modules modules/
#COPY params.yml params.yml
COPY server.R server.R
#COPY templates templates/
COPY ui.R ui.R
#COPY www www/

#RUN /var/task/bin/Rscript -e 'devtools::install_github("ruralinnovation/coriverse@cea7d0393a9b680e02414dec0e5a6f11761647eb", upgrade = FALSE)'
RUN /var/task/bin/Rscript -e 'packrat::restore(overwrite.dirty = TRUE)'

CMD deploy.R

## Docker provision
#FROM docker.io/coriverse/shinyapps:dashboard as install
#FROM docker.io/rocker/shiny-verse:3.5.1 as run
#COPY --from=install /data /data
#
#ARG gh_token
#ENV GITHUB_TOKEN=$gh_token
#ARG gh_token
#ENV GITHUB_PAT=$gh_token
#
#RUN apt update -y && apt install -y libgdal-dev libjq-dev libprotobuf-dev libv8-dev protobuf-compiler libudunits2-dev procps
#
##RUN /var/task/bin/Rscript -e 'devtools::install_github("ruralinnovation/coriverse", upgrade = FALSE)'
#
#WORKDIR /data
#
#RUN chmod ga+rw *.R
#RUN chmod ga+rwx /data
#RUN chmod -R ga+rw /data
#RUN rm -rf /data/packrat
#RUN mkdir -p /usr/local/lib/R/site-library
#RUN chmod ga+rwx /usr/local/lib/R/site-library
#RUN chmod -R ga+rw /usr/local/lib/R/site-library
#
#WORKDIR /srv/shiny-server
#
#RUN Rscript -e 'local({ r <- getOption("repos"); r["CRAN"] <- "http://cran.r-project.org"; options(repos=r); }); devtools::install_version("dplyr", version = "1.0.4");'
#RUN Rscript -e 'install.packages(c("packrat")); packrat::unbundle("/data/packrat.tar.gz", "/srv/shiny-server")'
#
##COPY .Renviron /srv/shiny-server/data/.Renviron
#COPY packrat/src /srv/shiny-server/data/packrat/src/
#COPY packrat/init.R /srv/shiny-server/data/packrat/init.R
#COPY packrat/packrat.lock /srv/shiny-server/data/packrat/packrat.lock
#COPY packrat/packrat.opts /srv/shiny-server/data/packrat/packrat.opts
#COPY deploy.R /srv/shiny-server/data/deploy.R
#COPY global.R /srv/shiny-server/data/global.R
#COPY server.R /srv/shiny-server/data/server.R
#COPY ui.R /srv/shiny-server/data/ui.R
#RUN chmod -R ga+rw /srv/shiny-server/*

# From here down is info specific to a given shiny app (including data updates)
# Docker deploy
FROM docker.io/coriverse/shinyapps:dashboard-run as run

WORKDIR /srv/shiny-server
# For normal deploy copy existing /srv/shiny-server/data to /srv/shiny-server/<app-name> ...
#RUN cp -ar /srv/shiny-server/data /srv/shiny-server/<app-name>

# ... and then COPY app files from build machine to /srv/shiny-server/<app-name> ...

# ... but in this case, use mininmal app itself as health check end-point...
RUN cp -ar /srv/shiny-server/data /srv/shiny-server/health
# ... and run minimal app from /srv/shiny-server/data

#COPY .Renviron /srv/shiny-server/data/.Renviron
COPY packrat/src /srv/shiny-server/data/packrat/src/
COPY packrat/init.R /srv/shiny-server/data/packrat/init.R
COPY packrat/packrat.lock /srv/shiny-server/data/packrat/packrat.lock
COPY packrat/packrat.opts /srv/shiny-server/data/packrat/packrat.opts
COPY data/* /srv/shiny-server/data/data/
COPY global.R /srv/shiny-server/data/global.R
#COPY library.R /srv/shiny-server/data/library.R
#COPY modules /srv/shiny-server/data/modules/
#COPY params.yml /srv/shiny-server/data/params.yml
COPY server.R /srv/shiny-server/data/server.R
#COPY templates /srv/shiny-server/data/templates/
COPY ui.R /srv/shiny-server/data/ui.R
#COPY www /srv/shiny-server/data/www/

RUN Rscript -e 'setwd("/srv/shiny-server/data"); packrat::restore(overwrite.dirty = TRUE)'

RUN chmod -R ga+rw /srv/shiny-server/data

CMD /usr/bin/shiny-server.sh

#ENTRYPOINT [ "Rscript", ".exec-shiny-app.R", "/srv/shiny-server/data", "8000" ]
#ENTRYPOINT [ "bash", "-c" ]

EXPOSE 3838
EXPOSE 8000
