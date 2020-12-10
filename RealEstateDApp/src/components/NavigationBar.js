import React, { Component } from 'react';

class NavigationBar extends Component {
  render() {
    const { account } = this.props;
    return (
      <div>
        <nav className="navbar navbar-expand-lg navbar-dark navbar-custom">
          <a className="navbar-brand" href="/#"><strong>Ether Appartments</strong></a>
          
          <ul className="navbar-nav ml-auto">
            <h4 className="nav-address">Account Address:</h4>
            <li className="nav-item">
              <a
                className="nav-link nav-link-custom"
                href={'#'}
                target="_blank"
                rel="noopener noreferrer"
              >
               <strong>{account}</strong>
              </a>
            </li>
          </ul>
        </nav>
      </div>
    )
  }
}

export default NavigationBar;
