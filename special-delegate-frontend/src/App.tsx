import logo from "./logo.svg";
import "./App.css";
import moralis from "moralis";
import React, { useEffect, useState } from "react";
import { useMoralis } from "react-moralis";
import { AppContainer } from "./App.styles";
import { AuthButton } from "./components/Buttons/Login+Signup/AuthButton";
import MembersList from "./components/MembersList/Members";
import { HorizontalLayoutMain } from "./Layout/Horizontals/Horizontal.style";
import Header from "./components/Header/Header";

const App: React.FC = () => {
  const { authenticate, isAuthenticated, user } = useMoralis();

  return (
    <AppContainer>
      <Header />

      {isAuthenticated && (
        <HorizontalLayoutMain>
          <MembersList />
        </HorizontalLayoutMain>
      )}
    </AppContainer>
  );
};

export default App;
