music = "SpooktuneRemix" 
encountertext = "You feel a breath on your back.\nNapstablook blocks the way." 
nextwaves = {"bullettest_chaserorb"}
wavetimer = 5.0
arenasize = {155, 130}

enemies = {
"Happstablook"
}

enemypositions = {
{0, 0}
}

possible_attacks = {"bullettest_bouncy", "bullettest_chaserorb", "bullettest_touhou", "waves", "waves2"}


    function EncounterStarting()
        PlayerSetings()
        PlayerItems()
    end

    function PlayerSetings()
        Player.lv = 1
        Player.hp = 20
        Player.name = "Chara"       
    end
  
  function PlayerItems()
      Inventory.AddCustomItems({"MnstrCndy", "MnstrCndy", "MnstrCndy", "PmpknRngs", "PmpknRngs"}, {0, 0, 0, 0, 0})
      Inventory.SetInventory({"MnstrCndy", "MnstrCndy", "MnstrCndy", "PmpknRngs", "PmpknRngs"})
  end

function EnemyDialogueStarting()
end

function EnemyDialogueEnding()
    nextwaves = { possible_attacks[math.random(#possible_attacks)] }
end

function DefenseEnding()
    encountertext = RandomEncounterText() 
end


function HandleSpare()
     State("ENEMYDIALOGUE") 
end

function HandleItem(ItemID)
   
    if ItemID == "MNSTRCNDY" then
        Player.heal(10)
        if Player.hp == 20 then
            BattleDialog({"You eat MnstrCndy\nYou recovered MAX hp"})
        else
            BattleDialog({"You eat MnstrCndy\nYou recovered 10 hp"})
        end
    end
    
    if ItemID == "PMPKNRNGS" then
        Player.heal(20)
        if Player.hp == 20 then
            BattleDialog({"You eat PmpknRngs\nYou recovered MAX hp"})
        else
            BattleDialog({"You eat MnstrCndy\nYou recovered 20 hp"})
        end
    end

end