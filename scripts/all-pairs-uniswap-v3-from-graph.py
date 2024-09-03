import requests
import json
import os
import duckdb

THEGRAPH_API_KEY = os.environ.get('THEGRAPH_API_KEY')

# starting from skip 0, read 1000 pairs each time,
# when we get less than 1000 pairs, we know we have reached the end

db = duckdb.connect('uniswap-v3-pools.db')

def init_db():
    db.execute("""
CREATE TABLE pools (
    id VARCHAR PRIMARY KEY,
    feeTier VARCHAR,
    liquidity VARCHAR,
    token0_id VARCHAR,
    token0_name VARCHAR,
    token0_symbol VARCHAR,
    token0Price VARCHAR,
    token1_id VARCHAR,
    token1_name VARCHAR,
    token1_symbol VARCHAR,
    token1Price VARCHAR,
    totalValueLockedToken0 VARCHAR,
    untrackedVolumeUSD VARCHAR,
    volumeToken0 VARCHAR,
    volumeToken1 VARCHAR,
    volumeUSD VARCHAR
);

    """)


def query_pairs(skip=0, first=1000):
    url = f"https://gateway.thegraph.com/api/{THEGRAPH_API_KEY}/subgraphs/id/5zvR82QoaXYFyDEKLZ9t6v9adgnptxYpKpSbxtgVENFV"

    headers = {
        "Content-Type": "application/json"
    }

    data = {"query": "{\n  pools(first: __first__, skip: __skip__) {\n    id\n    token0 {\n  id    symbol\n      name\n    }\n    token1 {\n  id    symbol\n      name\n    }\n    token0Price\n    token1Price\n    totalValueLockedToken0\n    volumeToken0\n    volumeToken1\n    volumeUSD\n    untrackedVolumeUSD\n    feeTier\n    liquidity\n }\n}\n".replace('__first__', str(first)).replace('__skip__', str(skip))}

    print(f'Querying with offset {skip}')

    response = requests.post(url, headers=headers, json=data)
    response.raise_for_status()
    resp = response.json()
    pools = resp.get('data', {}).get('pools', [])

    print(f'Got {len(pools)} pools')

    for pool in pools:
        id = pool.get('id')
        token0 = pool['token0']['id']
        token0_symbol = pool['token0']['symbol']
        token0_price = pool.get('token0Price')
        token1 = pool['token1']['id']
        token1_symbol = pool['token1']['symbol']
        token1_price = pool.get('token1Price')

        print(id)
        print(f'{token0} {token0_symbol:>8}' , f'{token1} {token1_symbol:>8}')
        print(f'{token0_price} {token1_price}')

        db.execute('''
        INSERT INTO pools VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
        ''', (
            pool['id'],
            pool['feeTier'],
            pool['liquidity'],
            pool['token0']['id'],
            pool['token0']['name'],
            pool['token0']['symbol'],
            pool['token0Price'],
            pool['token1']['id'],
            pool['token1']['name'],
            pool['token1']['symbol'],
            pool['token1Price'],
            pool['totalValueLockedToken0'],
            pool['untrackedVolumeUSD'],
            pool['volumeToken0'],
            pool['volumeToken1'],
            pool['volumeUSD'],
        ))

    if len(pools) == 1000:
        query_pairs(skip + 1000)



if __name__ == '__main__':
    try:
        init_db()
    except:
        pass
    query_pairs()
