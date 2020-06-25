-- A basic monster script skeleton you can copy and modify for your own creations.
comments = {"A strong odor of ectoplasm\rhas filled the room.", "Napstablook seems crazy."}
commands = {"Check", "Hug", "Laugh at", "Soothe"}
randomdialogue = {"I kill you!", "How do you look?!", "Give!\nme\nALONG!"}

sprite = "Happstablook" --Always PNG. Extension is added automatically.
name = "Napstablook"
hp = 80
atk = 5
def = 0
check = "A depressive ghost."
dialogbubble = "rightwide" -- See documentation for what bubbles you have available.
canspare = false
cancheck = false

flirt = 0

-- This handles the commands; all-caps versions of the commands list you have above.
function HandleCustomCommand(command)
    if command == "HUG" then
        BattleDialog({"You give [color:ff0000]Napstablook[color:ffffff] a hug."})
        currentdialogue = {"[voice:flowey]Hey!\nCut it out!"}
    elseif command == "LAUGH AT" then
        BattleDialog({"You poke fun at [color:ff0000]Napstablook[color:ffffff]'s\rhat.[next]", "His defense grows with rage."})
        currentdialogue = {"[voice:flowey][effect:shake]You wanna go?!"}
        def = 5 + def
    elseif command == "SOOTHE" then
      if flirt == 0 then
        BattleDialog({"You compliment [color:ff0000]Napstablook[color:ffffff]\rand his spooky figure."})
        currentdialogue = {"Who\n.[w:2].[w:2].[w:2]\nme?"}
        SetSprite("Happstablook_1")
      elseif flirt == 1 then
        BattleDialog({"You nod affectionately."})
        currentdialogue = {"A-are you sure?"}
        SetSprite("Happstablook_2")
      elseif flirt == 2 then
        BattleDialog({"You nod once more."})
        currentdialogue = {"But I'm tottaly...\nYou wouldn't like\na ghost like me..."}
      elseif flirt == 3 then
        BattleDialog({"You attempt to hold\nNapstablook's hand.[next]", "Your hand phases through\rher body.[next]", "[color:ff0000]Napstablook[color:ffffff] is flattered \ranyway."})
        currentdialogue = {"[voice:v_flowey-1]You're pretty cute\nI guess..."}
        comments = {"[color:ff0000]Napstablook[color:ffffff] wants to hang out\nsometime."}
        canspare = true
        SetSprite("HappstablookMercy")
      end
      flirt = 1 + flirt
    end
    if command == "CHECK" then
      BattleDialog({"[voice:v_flowey]Napstablook 10ATK 10DEF\nThey look like they would he sad\rall the time"})
   end
end



function OnDeath()
  Audio.Stop()
  currentdialogue = {"[noskip].....", "[noskip]You...", "[noskip]...tried to kill me?!", "[noskip]But i'm a ghost!\nYou can't kill ghosts!", "[noskip]I'm outta here!", "[func:Kill]"}
  State("ENEMYDIALOGUE")
end
