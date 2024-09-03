# from https://thegraph.com/explorer/subgraphs/EYCKATKGBKLWvSfwvBjzfCBmGwYNdVkduYXVivCsLRFu?view=Query&chain=arbitrum-one

import requests
import json
import os
import duckdb

THEGRAPH_API_KEY = os.environ.get('THEGRAPH_API_KEY')

# starting from skip 0, read 1000 pairs each time,
# when we get less than 1000 pairs, we know we have reached the end

db = duckdb.connect('uniswap-v2-pools.db')

def init_db():
    db.execute("""
CREATE TABLE pairs (
    id VARCHAR,
    token0Price VARCHAR,
    token1Price VARCHAR,
    token0_id VARCHAR,
    token0_symbol VARCHAR,
    token0_name VARCHAR,
    token1_id VARCHAR,
    token1_symbol VARCHAR,
    token1_name VARCHAR,
    reserve0 VARCHAR,
    reserve1 VARCHAR,
    totalSupply VARCHAR
);

    """)


def query_pairs(skip=0, first=1000):
    url = f"https://gateway.thegraph.com/api/{THEGRAPH_API_KEY}/subgraphs/id/EYCKATKGBKLWvSfwvBjzfCBmGwYNdVkduYXVivCsLRFu"

    headers = {
        "Content-Type": "application/json"
    }

    data = {"query": """
{
  pairs(first:__first__, skip: __skip__){
  id
  token0Price
  token1Price
  token0 {
    id
    symbol
    name
  }
  token1 {
    id
    symbol
    name
  }

  reserve0
  reserve1
  totalSupply
}
}
    """.replace('__first__', str(first)).replace('__skip__', str(skip))}

    print(f'Querying with offset {skip}')

    response = requests.post(url, headers=headers, json=data)
    response.raise_for_status()
    resp = response.json()
    pools = resp.get('data', {}).get('pairs', [])

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
            INSERT INTO pairs VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
            ''', (
                pool['id'],
                pool['token0Price'],
                pool['token1Price'],
                pool['token0']['id'],
                pool['token0']['symbol'],
                pool['token0']['name'],
                pool['token1']['id'],
                pool['token1']['symbol'],
                pool['token1']['name'],
                pool['reserve0'],
                pool['reserve1'],
                pool['totalSupply']
            ))


    if len(pools) == 1000:
        query_pairs(skip + 1000)


if __name__ == '__main__':
    try:
        init_db()
    except:
        pass
    query_pairs()
