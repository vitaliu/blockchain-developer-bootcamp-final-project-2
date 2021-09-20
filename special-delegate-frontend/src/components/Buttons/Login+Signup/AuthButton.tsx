import React from 'react';
import { SignUpButton } from './AuthButtons.styles'
import { useMoralis } from 'react-moralis';

export interface IAuthButton {
    isAuth: boolean;

}

export const AuthButton: React.FC<IAuthButton> = ({ isAuth }) => {
    const { authenticate, isAuthenticated, user, logout } = useMoralis();
    const handleOnClick = async () => {
        if (isAuthenticated) {
            logout()
        } else {
            await authenticate()
        }
    }
    return (
        <>
            <SignUpButton onClick={handleOnClick}>{ isAuthenticated ? 'Logout' : 'Sign In'}</SignUpButton>
        </>
    )
}