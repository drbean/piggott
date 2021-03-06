concrete MyConcrete of MyAbstract = CatEng ** open ResEng, Prelude, SyntaxEng, (P = ParadigmsEng), ExtraEng, IrregEng, ExtensionsEng in {

lincat
	ListNP	= ListNP;
	ListAP	= ListAP;
	NounCl = {s : ResEng.Tense => Anteriority => CPolarity => Order => Str; c : NPCase };
	Time	= Adv;
	TimeName	= CN;
	Times	= NP;
	Period	= Adv;
	SubordCl	= Adv;
	Title	= CN;
	Place	= NP;
	PlaceName	= CN;
	Motion	= VP;
	CoagentPrep = Prep;
	InstrumentPrep = Prep;
	ThemePrep = Prep;
	MannerPrep	= Prep;
	TimePrep	= Prep;
	LocPrep	= Prep;
	SourcePrep	= Prep;
	PP_coagent	= Adv;
	PP_instrument	= Adv;
	PP_theme	= Adv;
	PP_manner	= Adv;
	PP_time	= Adv;
	PP_location	= Adv;
	PP_source	= Adv;
	MassDet = Det;
	Partitive = N2;

param
  Auxiliary	= Do | Be | Should;
	-- VPs = Look_bad | Be_bad | Be_vp | Happening | Changing | Causative | Intens | Positing | Informing | Triangulating | Pred2A | Pass | ToPlace | WithPlace | WithTime | WithStyle | WithCl ;


oper

	no_Quant	= no_Quant;
	some_Quant	= P.mkQuant "some" "some" "some" "some";
	zero_mass_Quant = P.mkQuant "" nonExist;

	know_V = IrregEng.know_V;

	ModalVV	: Str -> Str -> Str -> Str -> Str ->
		{s : VVForm => Str; p : Str; typ : VVType } =
		\inf, pres, pp, prespp, presN -> {
		s = table {
			VVF VInf	=> inf ;
			VVF VPres => pres;
			VVF VPPart	=> pp ;
			VVF VPresPart	=> prespp ;
			-- VVF VPast	=> nonExist ;
			-- VVPastNeg	=> nonExist ;
			VVPresNeg	=> presN
			} ;
		p = [];
		typ	= VVAux;
		lock_VV = {}
		};

  tag : NP -> {s : Auxiliary => Polarity => Str} =
    \subj -> { s = case <(fromAgr subj.a).n, (fromAgr subj.a).g> of {
      <Sg,Fem> => table {
		      Do => table {Pos => "doesn't she"; Neg => "does she" };
		      Be => table {Pos => "isn't she"; Neg => "is she" };
		      Should => table {Pos => "shouldn't she"; Neg => "should she" }
		      };
      <Sg,Masc>  => table {
		      Do => table { Pos => "doesn't he"; Neg => "does he" };
		      Be => table {Pos => "isn't he"; Neg => "is he" };
		      Should => table {Pos => "shouldn't he"; Neg => "should he" }
		      };
      <Sg,Neutr> => table {
		      Do => table { Pos => "doesn't it"; Neg => "does it" };
		      Be => table {Pos => "isn't it"; Neg => "is it" };
		      Should => table {Pos => "shouldn't it"; Neg => "should it" }
		      };
      <Pl,_>	=> table {
		      Do => table { Pos => "don't they"; Neg => "do they" };
		      Be => table {Pos => "aren't they"; Neg => "are they" };
		      Should => table {Pos => "shouldn't they"; Neg => "should they" }
		      }
    }
  };

  --TagModal : NP -> VV -> VP -> QCl =
  --  \np, vv, vp2  -> let
  --  vp = Intens vv vp2;
  --  cl = Sentence np vp;
  --  aux = case ((vv . s) ! VVF VInf) of {
  --    "should" => Should
  --  };
  --in
  --{s = table {
  --  Pres => table {
  --    Simul => table {
  --      CPos => table {
  --        QDir => (cl.s ! Pres ! Simul ! CPos ! ODir False) ++ ((tag np).s ! aux ! Pos );
  --        QIndir => "nonExist" };
  --      CNeg True => table {
  --        QDir => (cl.s ! Pres ! Simul ! (CNeg True) ! ODir False) ++ ((tag np).s ! aux ! Neg );
  --        QIndir => "nonExist" };
  --      CNeg False => table {
  --        QDir => (cl.s ! Pres ! Simul ! (CNeg False) ! ODir False) ++ ((tag np).s ! aux ! Neg );
  --        QIndir => "nonExist" }
  --        }
  --      }
  -- };
  --lock_QCl = <>;
  --};

	mymkIP : (i,me,my : Str) -> Number -> {s : NPCase => Str ; n : Number} =
		\i,me,my,n -> 
		 { s = table {
				 NCase Nom => i;
				 NPAcc => me;
				 NCase Gen | NPNomPoss => my
				 } ;
			 n = Sg ;
		 };

	mymkConj : (and : Str) -> {s1 : Str ; s2 : Str ; n : Number} =
		\and ->
			{ s1 = [] ;
				s2 = and ;
				n = Pl ;
			};

	mymkPN_CN : (pn : PN) -> (cn : CN) -> {s : Number => Case => Str ; g : Gender } = 
		\pn,cn -> {
			s = table {
				Sg => table {
					Nom => pn.s ! Nom ++ cn.s ! Sg ! Nom;
					Gen => cn.s ! Sg ! Gen
					};
				Pl => table {
					Nom => pn.s ! Nom ++ cn.s ! Pl ! Nom;
					Gen => cn.s ! Pl ! Gen
					}
				};
			g = cn.g
			};

	mymkNP : (ncl : NounCl) -> {s : NPCase => Str ; a : Agr} =
		\ncl -> let string = ncl.s ! Pres ! Simul ! CPos ! oDir ;
								agreement = toAgr Sg P3 Neutr in {
			s = \\c => string;
			a = agreement;
		};

	myCltoNP : (str : Str) -> (cl : Cl) -> {s : NPCase => Str ; a : Agr} =
		\str,cl -> let np = str ++ cl.s ! Pres ! Simul ! CPos ! oDir ;
								agreement = toAgr Sg P3 Neutr in {
			s = \\_ => np;
			a = agreement;
		};

	myModPass3 : (cn : CN) -> (v3 : V3) -> (np : NP) ->
		{s : Number => Case => Str ; g : Gender } =
		\cn,v3,np -> {
			s = table {
				Sg => table {
					Nom => cn.s ! Sg ! Nom ++ v3.s ! VPPart ++ np.s ! NPAcc;
					Gen => cn.s ! Sg ! Nom ++ v3.s ! VPPart ++ np.s ! NPNomPoss
					};
				Pl => table {
					Nom => cn.s ! Pl ! Nom ++ v3.s ! VPPart ++ np.s ! NPAcc;
					Gen => cn.s ! Pl ! Nom ++ v3.s ! VPPart ++ np.s ! NPNomPoss
					}
				};
			g = cn.g
			};

	myPurposeAdv : (conj : Str) -> (vp : VP) -> {s : Str} = 
		\conj,vp -> let purpose = PurposeVP vp in
		{ s = conj ++ purpose.s;
			lock_Adv = {}
			};

	mymkAP_N : (adj : AP) -> (noun : N) -> { s : Number => Case => Str ; g : Gender } =
		\adj,noun ->
		{
			s = \\n,c => adj.s ! AgP3Sg Neutr ++ noun.s ! n ! c;
			g = noun.g
		};

lin
	Be_bad ap	= mkComp ap;
  Be_somewhere located	= mkComp located;
	Be_someone np	= mkComp np;
	Be_AdV_NP adv np = mkComp np;
	Be_vp comp	= mkVP comp;
	Look_bad verb adj	= mkVP verb adj;
  Locating prep item	= mkAdv prep item;
	Location det placename = mkNP det placename;
	FreqAdv times period	= mkAdv P.noPrep (mkNP times period);
	PeriodAdv times	= mkAdv P.noPrep times;
	Coagency prep coagent	= mkAdv prep coagent;
	Instrumenting prep instrument = mkAdv prep instrument;
	Themeing prep instrument = mkAdv prep instrument;
	Mannering prep style = mkAdv prep style;
	Timing prep time = mkAdv prep time;
	Sourcing prep source = mkAdv prep source;
	Happening action	=	mkVP action;
	Changing action patient	= mkVP action patient;
	V_NP_VP causal patient predicate	= mkVP causal patient predicate;
	Intens attitude predicate	= mkVP attitude predicate;
	V_that_S posit event	= mkVP posit event;
	V_S posit event	= ComplBareVS posit event;
	V_SC posit event	= ComplBareVS posit event;
	V_NP_that_S posit patient event	= mkVP posit patient event;
	V_NP_S = V_NP_that_S;
	V_NP_whether_S ask recipient topic = mkVP ask recipient topic;
  V_NP_NP v theme recipient = mkVP v theme recipient; 
  V_NP_AP v patient state = mkVP v patient state;
  GetPassV3 v np = insertObj (\\_ => v.s ! VPPart ++ v.p ++ v.c2 ++ v.c3 ++ np.s ! NPAcc) (predAux auxGet) ;
  -- GetNPPPart v np = insertObj (\\_ => np.s ! NPAcc ++ v.s ! VPPart ++ v.p ++ v.c2 ) (predAux auxGet) ;
	passive v = passiveVP v;
	Pass vp = PassVPSlash vp;
	V2Slash v2	= mkVPSlash v2;
	-- VSSlash vs	= mkVPSlash vs;
	V2VSlash v2v vp	= mkVPSlash v2v vp;
	V2ASlash v2a ap	= mkVPSlash v2a ap;
	V3Slash v3 np	= mkVPSlash v3 np;
	ModInf cn vp = mkCN cn vp;
	ModPass3 cn v3 np = myModPass3 cn v3 np;
	-- ModSlInf cn vpslash = mkCN cn vpslash;
	MassModInf n vp = mkCN( mkCN n) vp;
	Modified cn rcl = mkCN cn ( mkRS rcl);
	SubjRel	rp vp = mkRCl rp vp;
	ObjRel rp clslash = mkRCl rp clslash;
	EmptyRel slash = EmptyRelSlash slash;
	EmptyRelSlash slash = EmptyRelSlash slash;
	WayNP cl = myCltoNP "the way that" cl;
	HowNP cl = myCltoNP "how" cl;
	Gerund vp = GerundNP vp;
	ByGerund vp = ByVP vp;
	SClSlash	np vpslash = mkClSlash np vpslash;
	-- VPClSlash	vpslash = mkClSlash vpslash;
	FreeRClSlash cl = {
	  s = \\t,a,p,_ => "what" ++ cl.s ! t ! a ! p ! oDir ++ cl.c2;
		  c = npNom
			  } ;
	FreeRCl vp = let qcl = WH_Pred whatSg_IP vp in
	{
	  s = \\t,a,p,_ => qcl.s ! t ! a ! p ! QDir ;
		  c = npNom
			  };
	NomCl ncl = mymkNP ncl;
	Mannered np adv = mkNP np adv;
	Sourced np adv	= mkNP np adv;
	AdV_VP adv vp = mkVP adv vp;
  WithPlace v located	= mkVP (mkVP v) located;
  AdvVP adv vp	= mkVP adv vp;
	VPAdv vp adv = mkVP vp adv;
  WithTime action time	= mkVP action time;
  VP_PP_coagent v pp	= mkVP v pp;
	VP_PP_instrument vp pp = mkVP vp pp;
	VP_PP_theme vp pp = mkVP vp pp;
	VP_PP_manner vp pp = mkVP vp pp;
	VP_PP_time vp pp = mkVP pp;
	VP_PP_location vp located = mkVP vp located;
	WithCl vp cl = mkVP vp cl;
	WithClPre cl s = mkS cl s;
  -- Be_made_sth vp np = PassV3 vp np;

	ICompS i np = mkQS (mkQCl i np);
	YN cl	= mkQCl cl;
	WH_Pred ip vp	= mkQCl ip vp;
	WHose cn = mkIP (GenIP who_WH) cn;
	WH_ClSlash ip cslash	= mkQCl ip cslash;
	PosQ qcl	= mkQS qcl;
	NegQ qcl	= mkQS negativePol qcl;
	PosS cl	= mkS cl;
	NegS cl	= mkS negativePol cl;
	QUt q	= mkUtt q;
	Ut s	= mkUtt s;
	Sentence subject predicate	= mkCl subject predicate;
	Exist np = mkCl np;

	Yes	= yes_Utt;
	No	= no_Utt;
	NoAnswer	= ss "No answer";
	Answer np = mkUtt np;

	Inject i = mkSC( mkUtt i);

	Entity pn	= mkNP pn;
	Kind ap cn	= mkCN ap cn;
	MassKind ap n = mymkAP_N ap n;
  KindOfKind cn adv	= mkCN cn adv;
	KindInPlace cn adv	= mkCN cn adv;
	PlaceKind ap n = mkCN ap n;
	Membership det cn place = mkCl( Item det (KindInPlace cn place));
	CompoundN pn cn = mymkPN_CN pn cn;
	Ofpos n2 np	= mkCN n2 np;
	Ofpart part n = mkCN part (mkNP n);
	Item det noun	= mkNP det noun;
	MassItem udet ucn	= mkNP udet ucn;
	Titular cn = mkNP cn;
	PredetItem predet np	= mkNP predet np;

	a_Det	= a_Det;
	zero_Det_pl	= aPl_Det;
	zero_Det_sg	= mkDet zero_mass_Quant singularNum;
	the_mass_Det	= theSg_Det;
	some_mass_Det = mkDet some_Quant singularNum;
	any_mass_Det = mkDet any_Quant singularNum;
	theSg_Det	= theSg_Det;
	thePlural_Det = thePl_Det;
	Apos np	= mkDet (GenNP np);
	MassApos np	= mkDet (GenNP np);
	Apos_pl np	= mkDet (GenNP np) pluralNum;
	no_Det	= mkDet no_Quant;
	no_pl_Det	= mkDet no_Quant pluralNum;
	no_NP = mkNP( mkDet no_Quant);
	no_pl_NP = mkNP( mkDet no_Quant pluralNum);
	some_Det = mkDet some_Quant;
	some_pl_Det = mkDet some_Quant pluralNum;
	some_NP = mkNP( mkDet some_Quant);
	some_pl_NP = mkNP( mkDet some_Quant pluralNum);
	that_Pron = mkNP (mkDet that_Quant);
	List np1 np2 = mkListNP np1 np2;
	AddList np list = mkListNP np list;
	CloseList conj list = mkNP conj list;
	APList np1 np2 = mkListAP np1 np2;
	AddAP ap list = mkListAP ap list;
	CloseAP conj list = mkAP conj list;

	her_Det	= mkDet she_Pron;
	her_MassDet	= mkDet she_Pron;
	he_Det	= mkDet he_Pron;
	its	= mkDet it_Pron;

	she = mkNP she_Pron;
	he = mkNP he_Pron;
	it = mkNP it_Pron;
	they = mkNP they_Pron;
	you = mkNP youSg_Pron;

	who_WH	= mymkIP "who" "who" "whose" Sg;
	what_WH	= whatSg_IP;
	-- how_WH	= mkIP how_IAdv;
	that_RP	= ExtraEng.that_RP;
	-- in_which	=mkRP in_prep which_RP;
	-- where_RP	= mkRP "where";

	more	= more_CAdv;
	ComparaAP a np = mkAP a np;
	ComparaAdv cadv a np = mkAdv cadv a np;
	ComparaS a s = mkAP a s;
	AdjModified	a s = mkAP a s;
	As_as ap np	= mkAP as_CAdv ap np;
	AdvAdj adv adj = mkAP adv adj;
	A_PP a np = mkAP a np;
	VP_AP vp = PresPartAP vp;

  about_prep	= P.mkPrep "about";
  at_prep	= P.mkPrep "at";
	before_prep	= P.mkPrep "before";
  from_prep	= P.mkPrep "from";
  like_prep	= P.mkPrep "like";
	of_prep	= possess_Prep;
  part_prep	= part_Prep;
  up_prep	= P.mkPrep "up";

	person	= mkCN( P.mkN "person" "people");
	thing	= mkCN( P.mkN "thing");

	can	= can_VV;
	become	= P.mkV2 IrregEng.become_V;
	have	= P.mkV2 IrregEng.have_V;
	know_V2	= P.mkV2 know_V;
	know_VS	= P.mkVS know_V;

	Very_Adv a = ParadigmsEng.mkAdv ("very" ++ a.s);
	In_order_to vp = myPurposeAdv "in order" vp;
	because_Subj	= because_Subj;
	if_Subj	= if_Subj;
	when_Subj = when_Subj;
	so_Subj	= P.mkSubj "so";
	or_Conj	= or_Conj;
	and_Conj	= mymkConj "and";
	but_Conj	= mymkConj "but";

	Subjunct subj s	= mkAdv subj s;

 TagQ np vp = let
   cl = mkCl np vp;
   agreement = fromAgr np.a;
   number = agreement.n;
   gender = agreement.g;
   pos_tag = case <number,gender> of {
      <Sg,Fem> => table {
          "do" => "does she";
          "be" => "is she";
          "should" => "should she"
          };
      <Sg,Masc>  => table {
          "do" => "does he";
          "be" => "is he";
          "should" => "should he"
          };
      <Sg,Neutr> => table {
          "do" => "does it";
          "be" => "is it";
          "should" => "should it"
          };
      <Pl,_>  => table {
          "do" => "do they";
          "be" => "are they";
          "should" => "should they"
          }
   };
   neg_tag = case <number,gender> of {
      <Sg,Fem> => table {
          "do" => "doesn't she";
          "be" => "isn't she";
          "should" => "shouldn't she"
          };
      <Sg,Masc>  => table {
          "do" => "doesn't he";
          "be" => "isn't he";
          "should" => "shouldn't he"
          };
      <Sg,Neutr> => table {
          "do" => "doesn't it";
          "be" => "isn't it";
          "should" => "shouldn't it"
          };
      <Pl,_>  => table {
          "do" => "don't they";
          "be" => "aren't they";
          "should" => "shouldn't they"
          }
  };
 in
 {s = table {
     Pres => table {
       Simul => table {
         CPos => table {
           QDir => ((cl.s ! Pres ! Simul ! CPos ! ODir False) ++ (neg_tag ! "do" ));
           QIndir => "nonExist" };
         CNeg True => table {
           QDir => ((cl.s ! Pres ! Simul ! (CNeg True) ! ODir False) ++ (pos_tag ! "do"));
           QIndir => "nonExist" };
         CNeg False => table {
           QDir => ((cl.s ! Pres ! Simul ! (CNeg False) ! ODir False) ++ (pos_tag ! "do"));
           QIndir => "nonExist" }
           }
         }
   };
 lock_QCl = <>;
 };

 --TagNP np1 np2	= let
 --  cl = mkCl np1 np2;
 --in
 --{s = table {
 --    Pres => table {
 --      Simul => table {
 --        CPos => table {
 --          QDir => (cl.s ! Pres ! Simul ! CPos ! ODir False) ++ ((tag np1).s ! Be ! Pos );
 --          QIndir => "nonExist" };
 --        CNeg True => table {
 --          QDir => (cl.s ! Pres ! Simul ! (CNeg True) ! ODir False) ++ ((tag np1).s ! Be ! Neg );
 --          QIndir => "nonExist" };
 --        CNeg False => table {
 --          QDir => (cl.s ! Pres ! Simul ! (CNeg False) ! ODir False) ++ ((tag np1).s ! Be ! Neg );
 --          QIndir => "nonExist" }
 --          }
 --        }
 --  };
 --lock_QCl = <>;
 --};

 --TagAP np ap	= let
 --  cl = mkCl np ap;
 --in
 --{s = table {
 --    Pres => table {
 --      Simul => table {
 --        CPos => table {
 --          QDir => (cl.s ! Pres ! Simul ! CPos ! ODir False) ++ ((tag np).s ! Be ! Pos );
 --          QIndir => "nonExist" };
 --        CNeg True => table {
 --          QDir => (cl.s ! Pres ! Simul ! (CNeg True) ! ODir False) ++ ((tag np).s ! Be ! Neg );
 --          QIndir => "nonExist" };
 --        CNeg False => table {
 --          QDir => (cl.s ! Pres ! Simul ! (CNeg False) ! ODir False) ++ ((tag np).s ! Be ! Neg );
 --          QIndir => "nonExist" }
 --          }
 --        }
 --  };
 --lock_QCl = <>;
 --};

  TagComp np comp	= let cl = mkCl np (mkVP comp)
  in
  {s = table {
    Pres => table {
      Simul => table {
        CPos => table {
          QDir => (cl.s ! Pres ! Simul ! CPos ! ODir False) ++ ((tag np).s ! Be ! Pos );
          QIndir => "nonExist" };
        CNeg True => table {
          QDir => (cl.s ! Pres ! Simul ! CNeg True ! ODir False) ++ ((tag np).s ! Be ! Neg );
          QIndir => "nonExist" };
        CNeg False => table {
          QDir => (cl.s ! Pres ! Simul ! CNeg False ! ODir False) ++ ((tag np).s ! Be ! Neg );
          QIndir => "nonExist" }
          }
        }
     };
  lock_QCl = <>;
  };

}

-- vim: set ts=2 sts=2 sw=2 noet:
