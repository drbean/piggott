module WordsCharacters where

import qualified Data.Map as Map

gfWords = Map.fromList [
	("A",a)
	, ("ADV",adv)
	, ("Aux",aux)
	, ("CONJ",conj)
	, ("Det",det)
	, ("N",n)
	, ("PN",pn)
	, ("Pron",pron)
	, ("Prep",prep)
	, ("Rel",rel)
	, ("Tag",tag)
	, ("V",v) ]

wordlist = concat ( map (gfWords Map.!) (Map.keys gfWords) )

posMap = Map.fromList [
	("A","Adjective")
	, ("ADV","Adverb")
	, ("Aux","Auxiliary")
	, ("CONJ","Conjunction")
	, ("Det","Determiner")
	, ("N","Noun")
	, ("PN","Proper Noun")
	, ("Pron","Pronoun")
	, ("Prep","Preposition")
	, ("Rel","Relative Pronoun")
	, ("Tag","Question Tag")
	, ("V","Verb")
	]

a = [

	"country"
	, "emergency"
	, "famous"
	, "gone"
	, "invading"
	, "mad"
	, "only"
	, "strange"
	, "unusual"
	, "big"
	]

adv = [

	"back"
	, "home"
	, "later"
	, "more"
	, "never"
	, "out"
	, "together"
	, "whatsoever"
	, "just"
	, "on_Adv"
	]

aux = [
	"doesn't"
	, "don't"
	, "does"
	, "do"
	, "is"
	, "are"
	, "isn't"
	, "aren't"
	, "would"
	, "should"
	]
	
conj = [
	"so"
	, "but"
	, "before"
	, "because"
	, "if"
	, "when"
	]


det = [
	"'s"
	, "a few"
	, "just"
	, "one"
	, "this"
	, "any"
	, "all"
	, "0, _ or zero"
	, "a"
	, "an"
	, "no"
	, "some"
	, "the"

	]

n = [

	"news"
	, "brother"
	, "broadcast"
	, "brake"
	, "being"
	, "army"
	, "yard"
	, "world"
	, "word"
	, "wife"
	, "way"
	, "vanguard"
	, "uncle"
	, "story"
	, "step-grandfather"
	, "sound"
	, "skeptic"
	, "sin"
	, "sense of humor"
	, "radio"
	, "program"
	, "planet"
	, "night"
	, "minute"
	, "Martian"
	, "man"
	, "idea"
	, "huff"
	, "house"
	, "hoax"
	, "family"
	, "end"
	, "drama"
	, "doctor"
	, "direction"
	, "car"
	, "Chevrolet automobile"
	, "nothing"
	, "recreation"
	, "rubber"
	, "scent"
	, "something"
	, "each other"
	, "anytime"
	, "anyone"
	, "11 o'clock"
	, "1938"
	]

pn = [

	"Doctor"
	, "The Doctor"
	, "Joe"
	, "Mars"
	, "Mercury Theater"
	, "New Jersey"
	, "Orson Welles"
	]

pron = [
	"who"
	, "she"
	, "her"
	, "he"
	, "his"
	, "himself"
	, "it"
	, "they"
	, "them"
	, "their"

	]

prep = [

	"from"
	, "in"
	, "into"
	, "of"
	, "on"
	, "to"
	, "with"
	, "within"
	, "around to"
	, "over to"
	, "back out into"
	, "at"
	, "about"
	]

rel = [
	"that"
	, "who"
	,	"where"
	]

tag = [
	"doesn't he"
	, "doesn't she"
	, "doesn't it"
	, "don't they"
	, "does he"
	, "does she"
	, "does it"
	, "do they"
	, "isn't he"
	, "isn't she"
	, "isn't it"
	, "aren't they"
	, "is he"
	, "is she"
	, "is it"
	, "are they"
	]

v = [

	"come"
	, "confess"
	, "convince"
	, "figure"
	, "find"
	, "get"
	, "go over to"
	, "drive around to"
	, "walk back out into"
	, "hear"
	, "involve"
	, "keep"
	, "land"
	, "leave"
	, "make"
	, "react"
	, "repeat"
	, "repent"
	, "say"
	, "see"
	, "smell"
	, "talk"
	, "tell"
	, "think"
	, "turn on"
	, "get up"
	, "wait"
	, "listen"
	, "call"
	, "can"
	, "begin"
	, "burn"
	, "announce"
	]

{-


11 o'clock	: N;
1938	: N;
a few	: Det;
about	: Prep;
all	: Det;
announce	: VS;
any	: Det;
anyone	: N;
anytime	: N;
army	: CN;
around to	: Prep;
at	: Prep;
back out into	: Prep;
because	: Conj;
before	: Conj;
begin	: VV;
being	: CN;
big	: A;
brake	: CN;
broadcast	: CN;
brother	: CN;
burn	: V;
but	: Conj;
call	: V3;
can	: VV;
car	: CN;
Chevrolet automobile	: CN;
come	: V;
confess	: V;
convince	: V2S;
country	: A;
direction	: CN;
doctor	: CN;
Doctor	: PN;
The Doctor	: PN;
drama	: CN;
drive around to	: V2;
each other	: N;
emergency	: A;
end	: CN;
family	: CN;
famous	: A;
figure	: VS;
find	: VS;
from	: Prep;
get	: V2;
get up	: V;
go over to	: V2;
gone	: A;
he : Pron;
hear	: V2S;
himself : Pron;
hoax	: CN;
home	: Adv;
house	: CN;
huff	: CN;
idea	: CN;
in_prep	: LocPrep;
into	: Prep;
invading	: A;
involve	: V2;
it	: Pron;
Joe	: PN;
just	: AdV;
just	: Det;
keep	: VV;
land	: V2;
later	: Adv;
leave	: V;
listen	: V2;
mad	: A;
make	: V2;
Mars	: PN;
Martian	: PN;
man	: CN;
Mercury Theater	: PN;
minute	: CN;
more	: Adv;
never	: Adv;
New Jersey	: PN;
news	: N;
night	: CN;
no	: Det;
not
nothing	: N;
of	: Prep;
on	: Prep;
on_Adv	: Adv;
one	: Det;
only	: AP;
Orson Welles	: PN;
out	: Adv;
over	: Adv;
over to	: Prep;
planet	: CN;
program	: CN;
radio	: CN;
react	: V2;
recreation	: N;
repeat	: V2;
repent	: V2;
rubber	: N;
say	: V2;
scent	: N2;
see	: V3;
sense of humor	: CN;
sin	: CN;
skeptic	: CN;
smell	: VV;
so	: Conj;
something	: N;
sound	: CN;
step-grandfather	: CN;
story	: CN;
strange	: A;
talk	: V;
tell	: V2S;
tell to	: V2V;
that	: Rel;
their	: Pron;
they	: Pron;
think	: VS;
this	: Det;
to	: Prep;
together	: Adv;
turn on	: V;
uncle	: CN;
unusual	: A;
vanguard	: CN;
wait	: V2;
walk back out into	: V2;
way	: CN;
whatsoever	: Adv;
when	: Subj;
where
who
wife	: CN;
with	: Prep;
within	: Prep;
without
word	: CN;
world	: CN;
yard	: CN;
young

-}

-- vim: set ts=2 sts=2 sw=2 noet:
