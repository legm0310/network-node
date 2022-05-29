FROM bcgovimages/von-image:node-1.12-4



ENV LOG_LEVEL ${LOG_LEVEL:-info}
ENV RUST_LOG ${RUST_LOG:-warning}


ADD config ./config
ADD server/requirements.txt server/
#RUN pip install --upgrade pip
RUN pip install --no-cache-dir -r server/requirements.txt

COPY --chown=indy:indy pool_transactions_genesis /home/indy/ledger/sandbox/
COPY --chown=indy:indy domain_transactions_genesis /home/indy/ledger/sandbox/

ADD --chown=indy:indy indy_config.py /etc/indy/
ADD --chown=indy:indy . $HOME
RUN pip install pytz
# RUN ln -sf /home/indy/.pyenv/versions/3.6.13/lib/python3.6/site-packages/pytz/zoneinfo/Asia /etc/localtime

RUN mkdir -p \
    $HOME/cli-scripts \
    && chmod -R ug+rw $HOME/cli-scripts
