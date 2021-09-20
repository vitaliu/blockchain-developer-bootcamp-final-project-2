import React from "react";
import * as Styled from "./Members.style";
const MembersList: React.FC = () => {
  return (
    <div>
      <Styled.MembersList>
        {[1, 2, 3].map((member: any, i: number) => {
          return <Styled.MemberCell>Member number {i}</Styled.MemberCell>;
        })}
      </Styled.MembersList>
      <ul></ul>
    </div>
  );
};
export default MembersList;
