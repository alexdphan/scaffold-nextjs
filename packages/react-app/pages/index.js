import React, { useContext } from "react";
import { Contract, Account, Header } from "../components";
import { Web3Consumer } from "../helpers/Web3Context";

function Home({ web3 }) {
  console.log(`🗄 web3 context:`, web3);

  return (
    <>
      {/* Page Header start */}
      <div className="flex items-center justify-between flex-1">
        <Header />
        <div className="mr-6">
          <Account {...web3} />
        </div>
      </div>
      {/* Page Header end */}

      {/* Main Page Content start */}
      <div className="flex flex-col items-center flex-1 w-full h-screen">
        <div className="text-center" style={{ margin: 64 }}>
          <span>This App is powered by Scaffold-eth & Next.js!</span>
          <br />
          <span>
            Added{" "}
            <a href="https://tailwindcomponents.com/cheatsheet/" target="_blank" rel="noreferrer">
              TailwindCSS
            </a>{" "}
            for easier styling.
          </span>
        </div>
        <div className="text-center">
          <Contract
            name="YourContract"
            signer={web3.userSigner}
            provider={web3.localProvider}
            address={web3.address}
            blockExplorer={web3.blockExplorer}
            contractConfig={web3.contractConfig}
          />
        </div>
      </div>
    </>
  );
}

export default Web3Consumer(Home);
