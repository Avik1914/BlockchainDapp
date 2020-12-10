import React, { Component } from 'react'
import AddLand from './AddLand';
import LandsForSale from './LandsForSale';
import ListLand from './ListLand';
import SoldLands from './SoldLands';

class Content extends Component {
  render() {
    const { addLand, lands, buyLand, account, listLand } = this.props
    return (
      <div id="content">
        <p></p>
        {
          account === '0x8414A633f97C53a6B7e6Bf70Ad38bfA2B1c78680' ? // modify to contract owner
            <AddLand addLand={addLand} /> :
            <div></div>
        }
        <p>&nbsp;</p>
        <LandsForSale lands={lands} buyLand={buyLand} account={account} />
        <p>&nbsp;</p>
        <ListLand listLand={listLand} />
        <p>&nbsp;</p>
        <SoldLands lands={lands} account={account} listLand={listLand} />
      </div>
    )
  }
}

export default Content
