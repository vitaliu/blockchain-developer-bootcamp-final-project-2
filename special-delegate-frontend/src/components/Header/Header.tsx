import React from "react";
import * as Styled from "./Header.style";
import {useMoralis} from 'react-moralis'
import { AuthButton } from "../Buttons/Login+Signup/AuthButton";
const Header: React.FC = () => {
    const { authenticate, isAuthenticated, user } = useMoralis();
    return (
        <Styled.HeaderContainer>
                  {isAuthenticated ? <Styled.Title>{user!.get("username")}'s Dashboard </Styled.Title> : <Styled.Title>Sign in to your Dashboard </Styled.Title>}

            <AuthButton isAuth={isAuthenticated} />
        </Styled.HeaderContainer>
    );
}

export default Header;