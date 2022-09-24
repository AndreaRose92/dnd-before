import React, { useState } from "react"

export const DiceContext = React.createContext()

export const DiceProvider = ({children}) => {
    const [diceHistory, setDiceHistory] = useState([])
    return (
        <DiceContext.Provider value={{diceHistory, setDiceHistory}}>
            {children}
        </DiceContext.Provider>
    )
}

export const diceRoll = (name = '', modifier = '', dSize = 20, amt = 1) => {
    let total = 0
    let rolls = []
    for (let i = 0; i < amt; i++) {
        rolls.push(Math.floor(Math.random() * (dSize - 1) + 1))
    }
    total = rolls.reduce((a,b)=> a+b, total) + parseInt(modifier)
    const result = {name: name, modifier: modifier, total: total, dSize: dSize, amt: amt, rolls: rolls}
    return result
}
