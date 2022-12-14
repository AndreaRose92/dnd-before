import React, { useContext } from "react";
import { DiceContext, diceRoll } from "../../hookComponents";
import { ProficiencyBox, SkillButton } from "../../styles";

export const SkillBox = ({ skills, prof_bonus }) => {

  const {diceHistory, setDiceHistory} = useContext(DiceContext)
  
  const skillCheck = (skill, mod) => {
    let newRoll = diceRoll(skill, mod)
    if (!diceHistory[0]) { newRoll.id = 1 }
    else { newRoll.id = diceHistory[diceHistory.length - 1].id + 1 }
    setDiceHistory(history => [...history,newRoll])
  }

    const renderSkills = skills.map((skill) => {
      let mod = skill.is_proficient ? skill.modifier + prof_bonus : skill.modifier
      let displayMod = mod > 0 ? `+${mod}` : mod
      return (
        <React.Fragment key={skill.name}>
          <h3>{skill.is_proficient ? '●' : '○'} </h3>
          <h3>{skill.stat.slice(0, 3)}</h3>
          <h3 className='skill'>{skill.name}</h3>
          <SkillButton onClick={()=>skillCheck(skill.name, mod)}>{displayMod}</SkillButton>
        </React.Fragment>
      );
    });
    return (
      <ProficiencyBox>
        <div className='pro-header'>
          <p>PROF.</p>
          <p>MODIFIER</p>
          <p className='skill'>SKILL</p>
          <p>BONUS</p>
        </div>
        <div className='pro-grid'>{renderSkills}</div>
      </ProficiencyBox>
    );
  };