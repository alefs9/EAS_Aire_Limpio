#define rand	pan_rand
#define pthread_equal(a,b)	((a)==(b))
#if defined(HAS_CODE) && defined(VERBOSE)
	#ifdef BFS_PAR
		bfs_printf("Pr: %d Tr: %d\n", II, t->forw);
	#else
		cpu_printf("Pr: %d Tr: %d\n", II, t->forw);
	#endif
#endif
	switch (t->forw) {
	default: Uerror("bad forward move");
	case 0:	/* if without executable clauses */
		continue;
	case 1: /* generic 'goto' or 'skip' */
		IfNotBlocked
		_m = 3; goto P999;
	case 2: /* generic 'else' */
		IfNotBlocked
		if (trpt->o_pm&1) continue;
		_m = 3; goto P999;

		 /* CLAIM mutex_liberado */
	case 3: // STATE 1 - _spin_nvr.tmp:10 - [(!((!((workersTerminados==4))||!(mutex))))] (6:0:0 - 1)
		
#if defined(VERI) && !defined(NP)
#if NCLAIMS>1
		{	static int reported1 = 0;
			if (verbose && !reported1)
			{	int nn = (int) ((Pclaim *)pptr(0))->_n;
				printf("depth %ld: Claim %s (%d), state %d (line %d)\n",
					depth, procname[spin_c_typ[nn]], nn, (int) ((Pclaim *)pptr(0))->_p, src_claim[ (int) ((Pclaim *)pptr(0))->_p ]);
				reported1 = 1;
				fflush(stdout);
		}	}
#else
		{	static int reported1 = 0;
			if (verbose && !reported1)
			{	printf("depth %d: Claim, state %d (line %d)\n",
					(int) depth, (int) ((Pclaim *)pptr(0))->_p, src_claim[ (int) ((Pclaim *)pptr(0))->_p ]);
				reported1 = 1;
				fflush(stdout);
		}	}
#endif
#endif
		reached[3][1] = 1;
		if (!( !(( !((now.workersTerminados==4))|| !(((int)now.mutex))))))
			continue;
		/* merge: assert(!(!((!((workersTerminados==4))||!(mutex)))))(0, 2, 6) */
		reached[3][2] = 1;
		spin_assert( !( !(( !((now.workersTerminados==4))|| !(((int)now.mutex))))), " !( !(( !((workersTerminados==4))|| !(mutex))))", II, tt, t);
		/* merge: .(goto)(0, 7, 6) */
		reached[3][7] = 1;
		;
		_m = 3; goto P999; /* 2 */
	case 4: // STATE 10 - _spin_nvr.tmp:15 - [-end-] (0:0:0 - 1)
		
#if defined(VERI) && !defined(NP)
#if NCLAIMS>1
		{	static int reported10 = 0;
			if (verbose && !reported10)
			{	int nn = (int) ((Pclaim *)pptr(0))->_n;
				printf("depth %ld: Claim %s (%d), state %d (line %d)\n",
					depth, procname[spin_c_typ[nn]], nn, (int) ((Pclaim *)pptr(0))->_p, src_claim[ (int) ((Pclaim *)pptr(0))->_p ]);
				reported10 = 1;
				fflush(stdout);
		}	}
#else
		{	static int reported10 = 0;
			if (verbose && !reported10)
			{	printf("depth %d: Claim, state %d (line %d)\n",
					(int) depth, (int) ((Pclaim *)pptr(0))->_p, src_claim[ (int) ((Pclaim *)pptr(0))->_p ]);
				reported10 = 1;
				fflush(stdout);
		}	}
#endif
#endif
		reached[3][10] = 1;
		if (!delproc(1, II)) continue;
		_m = 3; goto P999; /* 0 */

		 /* CLAIM terminacion */
	case 5: // STATE 1 - _spin_nvr.tmp:4 - [(!((workersTerminados==4)))] (0:0:0 - 1)
		
#if defined(VERI) && !defined(NP)
#if NCLAIMS>1
		{	static int reported1 = 0;
			if (verbose && !reported1)
			{	int nn = (int) ((Pclaim *)pptr(0))->_n;
				printf("depth %ld: Claim %s (%d), state %d (line %d)\n",
					depth, procname[spin_c_typ[nn]], nn, (int) ((Pclaim *)pptr(0))->_p, src_claim[ (int) ((Pclaim *)pptr(0))->_p ]);
				reported1 = 1;
				fflush(stdout);
		}	}
#else
		{	static int reported1 = 0;
			if (verbose && !reported1)
			{	printf("depth %d: Claim, state %d (line %d)\n",
					(int) depth, (int) ((Pclaim *)pptr(0))->_p, src_claim[ (int) ((Pclaim *)pptr(0))->_p ]);
				reported1 = 1;
				fflush(stdout);
		}	}
#endif
#endif
		reached[2][1] = 1;
		if (!( !((now.workersTerminados==4))))
			continue;
		_m = 3; goto P999; /* 0 */
	case 6: // STATE 6 - _spin_nvr.tmp:6 - [-end-] (0:0:0 - 1)
		
#if defined(VERI) && !defined(NP)
#if NCLAIMS>1
		{	static int reported6 = 0;
			if (verbose && !reported6)
			{	int nn = (int) ((Pclaim *)pptr(0))->_n;
				printf("depth %ld: Claim %s (%d), state %d (line %d)\n",
					depth, procname[spin_c_typ[nn]], nn, (int) ((Pclaim *)pptr(0))->_p, src_claim[ (int) ((Pclaim *)pptr(0))->_p ]);
				reported6 = 1;
				fflush(stdout);
		}	}
#else
		{	static int reported6 = 0;
			if (verbose && !reported6)
			{	printf("depth %d: Claim, state %d (line %d)\n",
					(int) depth, (int) ((Pclaim *)pptr(0))->_p, src_claim[ (int) ((Pclaim *)pptr(0))->_p ]);
				reported6 = 1;
				fflush(stdout);
		}	}
#endif
#endif
		reached[2][6] = 1;
		if (!delproc(1, II)) continue;
		_m = 3; goto P999; /* 0 */

		 /* PROC Main */
	case 7: // STATE 1 - modelo_sincronizacion.pml:108 - [((iter<2))] (0:0:0 - 1)
		IfNotBlocked
		reached[1][1] = 1;
		if (!((((P1 *)_this)->iter<2)))
			continue;
		_m = 3; goto P999; /* 0 */
	case 8: // STATE 2 - modelo_sincronizacion.pml:113 - [cambiosTotales = 0] (0:0:1 - 1)
		IfNotBlocked
		reached[1][2] = 1;
		(trpt+1)->bup.oval = now.cambiosTotales;
		now.cambiosTotales = 0;
#ifdef VAR_RANGES
		logval("cambiosTotales", now.cambiosTotales);
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 9: // STATE 3 - modelo_sincronizacion.pml:114 - [sumaControl = 0] (0:0:1 - 1)
		IfNotBlocked
		reached[1][3] = 1;
		(trpt+1)->bup.oval = now.sumaControl;
		now.sumaControl = 0;
#ifdef VAR_RANGES
		logval("sumaControl", now.sumaControl);
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 10: // STATE 4 - modelo_sincronizacion.pml:115 - [workersTerminados = 0] (0:0:1 - 1)
		IfNotBlocked
		reached[1][4] = 1;
		(trpt+1)->bup.oval = now.workersTerminados;
		now.workersTerminados = 0;
#ifdef VAR_RANGES
		logval("workersTerminados", now.workersTerminados);
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 11: // STATE 5 - modelo_sincronizacion.pml:123 - [i = 0] (0:0:1 - 1)
		IfNotBlocked
		reached[1][5] = 1;
		(trpt+1)->bup.oval = ((P1 *)_this)->i;
		((P1 *)_this)->i = 0;
#ifdef VAR_RANGES
		logval("Main:i", ((P1 *)_this)->i);
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 12: // STATE 6 - modelo_sincronizacion.pml:126 - [((i<4))] (0:0:0 - 1)
		IfNotBlocked
		reached[1][6] = 1;
		if (!((((P1 *)_this)->i<4)))
			continue;
		_m = 3; goto P999; /* 0 */
	case 13: // STATE 7 - modelo_sincronizacion.pml:127 - [(run Worker(i))] (0:0:0 - 1)
		IfNotBlocked
		reached[1][7] = 1;
		if (!(addproc(II, 1, 0, ((P1 *)_this)->i)))
			continue;
		_m = 3; goto P999; /* 0 */
	case 14: // STATE 8 - modelo_sincronizacion.pml:128 - [i = (i+1)] (0:0:1 - 1)
		IfNotBlocked
		reached[1][8] = 1;
		(trpt+1)->bup.oval = ((P1 *)_this)->i;
		((P1 *)_this)->i = (((P1 *)_this)->i+1);
#ifdef VAR_RANGES
		logval("Main:i", ((P1 *)_this)->i);
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 15: // STATE 9 - modelo_sincronizacion.pml:130 - [((i>=4))] (0:0:1 - 1)
		IfNotBlocked
		reached[1][9] = 1;
		if (!((((P1 *)_this)->i>=4)))
			continue;
		if (TstOnly) return 1; /* TT */
		/* dead 1: i */  (trpt+1)->bup.oval = ((P1 *)_this)->i;
#ifdef HAS_CODE
		if (!readtrail)
#endif
			((P1 *)_this)->i = 0;
		_m = 3; goto P999; /* 0 */
	case 16: // STATE 14 - modelo_sincronizacion.pml:140 - [((workersTerminados==4))] (0:0:0 - 3)
		IfNotBlocked
		reached[1][14] = 1;
		if (!((now.workersTerminados==4)))
			continue;
		_m = 3; goto P999; /* 0 */
	case 17: // STATE 15 - modelo_sincronizacion.pml:146 - [assert((cambiosTotales==sumaControl))] (0:0:0 - 1)
		IfNotBlocked
		reached[1][15] = 1;
		spin_assert((now.cambiosTotales==now.sumaControl), "(cambiosTotales==sumaControl)", II, tt, t);
		_m = 3; goto P999; /* 0 */
	case 18: // STATE 16 - modelo_sincronizacion.pml:153 - [((cambiosTotales==0))] (0:0:0 - 1)
		IfNotBlocked
		reached[1][16] = 1;
		if (!((now.cambiosTotales==0)))
			continue;
		_m = 3; goto P999; /* 0 */
	case 19: // STATE 17 - modelo_sincronizacion.pml:154 - [printf('Convergencia alcanzada en iter %d\\n',iter)] (0:31:0 - 1)
		IfNotBlocked
		reached[1][17] = 1;
		Printf("Convergencia alcanzada en iter %d\n", ((P1 *)_this)->iter);
		/* merge: goto :b0(31, 18, 31) */
		reached[1][18] = 1;
		;
		/* merge: printf('Todos los workers terminaron\\n')(31, 29, 31) */
		reached[1][29] = 1;
		Printf("Todos los workers terminaron\n");
		/* merge: printf('Terminado sin errores de sincronizacion\\n')(31, 30, 31) */
		reached[1][30] = 1;
		Printf("Terminado sin errores de sincronizacion\n");
		_m = 3; goto P999; /* 3 */
	case 20: // STATE 20 - modelo_sincronizacion.pml:162 - [(1)] (26:0:1 - 1)
		IfNotBlocked
		reached[1][20] = 1;
		if (!(1))
			continue;
		/* merge: .(goto)(26, 22, 26) */
		reached[1][22] = 1;
		;
		/* merge: iter = (iter+1)(26, 23, 26) */
		reached[1][23] = 1;
		(trpt+1)->bup.oval = ((P1 *)_this)->iter;
		((P1 *)_this)->iter = (((P1 *)_this)->iter+1);
#ifdef VAR_RANGES
		logval("Main:iter", ((P1 *)_this)->iter);
#endif
		;
		/* merge: .(goto)(0, 27, 26) */
		reached[1][27] = 1;
		;
		_m = 3; goto P999; /* 3 */
	case 21: // STATE 23 - modelo_sincronizacion.pml:165 - [iter = (iter+1)] (0:26:1 - 2)
		IfNotBlocked
		reached[1][23] = 1;
		(trpt+1)->bup.oval = ((P1 *)_this)->iter;
		((P1 *)_this)->iter = (((P1 *)_this)->iter+1);
#ifdef VAR_RANGES
		logval("Main:iter", ((P1 *)_this)->iter);
#endif
		;
		/* merge: .(goto)(0, 27, 26) */
		reached[1][27] = 1;
		;
		_m = 3; goto P999; /* 1 */
	case 22: // STATE 24 - modelo_sincronizacion.pml:168 - [((iter>=2))] (31:0:1 - 1)
		IfNotBlocked
		reached[1][24] = 1;
		if (!((((P1 *)_this)->iter>=2)))
			continue;
		if (TstOnly) return 1; /* TT */
		/* dead 1: iter */  (trpt+1)->bup.oval = ((P1 *)_this)->iter;
#ifdef HAS_CODE
		if (!readtrail)
#endif
			((P1 *)_this)->iter = 0;
		/* merge: goto :b0(31, 25, 31) */
		reached[1][25] = 1;
		;
		/* merge: printf('Todos los workers terminaron\\n')(31, 29, 31) */
		reached[1][29] = 1;
		Printf("Todos los workers terminaron\n");
		/* merge: printf('Terminado sin errores de sincronizacion\\n')(31, 30, 31) */
		reached[1][30] = 1;
		Printf("Terminado sin errores de sincronizacion\n");
		_m = 3; goto P999; /* 3 */
	case 23: // STATE 29 - modelo_sincronizacion.pml:173 - [printf('Todos los workers terminaron\\n')] (0:31:0 - 5)
		IfNotBlocked
		reached[1][29] = 1;
		Printf("Todos los workers terminaron\n");
		/* merge: printf('Terminado sin errores de sincronizacion\\n')(31, 30, 31) */
		reached[1][30] = 1;
		Printf("Terminado sin errores de sincronizacion\n");
		_m = 3; goto P999; /* 1 */
	case 24: // STATE 31 - modelo_sincronizacion.pml:175 - [-end-] (0:0:0 - 1)
		IfNotBlocked
		reached[1][31] = 1;
		if (!delproc(1, II)) continue;
		_m = 3; goto P999; /* 0 */

		 /* PROC Worker */
	case 25: // STATE 1 - modelo_sincronizacion.pml:31 - [cambiosLocal = 0] (0:11:1 - 1)
		IfNotBlocked
		reached[0][1] = 1;
		(trpt+1)->bup.oval = ((P0 *)_this)->cambiosLocal;
		((P0 *)_this)->cambiosLocal = 0;
#ifdef VAR_RANGES
		logval("Worker:cambiosLocal", ((P0 *)_this)->cambiosLocal);
#endif
		;
		/* merge: .(goto)(11, 5, 11) */
		reached[0][5] = 1;
		;
		/* merge: printf('Worker %d inicio\\n',id)(11, 6, 11) */
		reached[0][6] = 1;
		Printf("Worker %d inicio\n", ((P0 *)_this)->id);
		_m = 3; goto P999; /* 2 */
	case 26: // STATE 2 - modelo_sincronizacion.pml:32 - [cambiosLocal = 1] (0:11:1 - 1)
		IfNotBlocked
		reached[0][2] = 1;
		(trpt+1)->bup.oval = ((P0 *)_this)->cambiosLocal;
		((P0 *)_this)->cambiosLocal = 1;
#ifdef VAR_RANGES
		logval("Worker:cambiosLocal", ((P0 *)_this)->cambiosLocal);
#endif
		;
		/* merge: .(goto)(11, 5, 11) */
		reached[0][5] = 1;
		;
		/* merge: printf('Worker %d inicio\\n',id)(11, 6, 11) */
		reached[0][6] = 1;
		Printf("Worker %d inicio\n", ((P0 *)_this)->id);
		_m = 3; goto P999; /* 2 */
	case 27: // STATE 3 - modelo_sincronizacion.pml:33 - [cambiosLocal = 2] (0:11:1 - 1)
		IfNotBlocked
		reached[0][3] = 1;
		(trpt+1)->bup.oval = ((P0 *)_this)->cambiosLocal;
		((P0 *)_this)->cambiosLocal = 2;
#ifdef VAR_RANGES
		logval("Worker:cambiosLocal", ((P0 *)_this)->cambiosLocal);
#endif
		;
		/* merge: .(goto)(11, 5, 11) */
		reached[0][5] = 1;
		;
		/* merge: printf('Worker %d inicio\\n',id)(11, 6, 11) */
		reached[0][6] = 1;
		Printf("Worker %d inicio\n", ((P0 *)_this)->id);
		_m = 3; goto P999; /* 2 */
	case 28: // STATE 6 - modelo_sincronizacion.pml:36 - [printf('Worker %d inicio\\n',id)] (0:11:0 - 4)
		IfNotBlocked
		reached[0][6] = 1;
		Printf("Worker %d inicio\n", ((P0 *)_this)->id);
		_m = 3; goto P999; /* 0 */
	case 29: // STATE 7 - modelo_sincronizacion.pml:45 - [(!(mutex))] (12:0:2 - 1)
		IfNotBlocked
		reached[0][7] = 1;
		if (!( !(((int)now.mutex))))
			continue;
		/* merge: mutex = 1(12, 8, 12) */
		reached[0][8] = 1;
		(trpt+1)->bup.ovals = grab_ints(2);
		(trpt+1)->bup.ovals[0] = ((int)now.mutex);
		now.mutex = 1;
#ifdef VAR_RANGES
		logval("mutex", ((int)now.mutex));
#endif
		;
		/* merge: enSeccionCritica = (enSeccionCritica+1)(12, 9, 12) */
		reached[0][9] = 1;
		(trpt+1)->bup.ovals[1] = now.enSeccionCritica;
		now.enSeccionCritica = (now.enSeccionCritica+1);
#ifdef VAR_RANGES
		logval("enSeccionCritica", now.enSeccionCritica);
#endif
		;
		/* merge: assert((enSeccionCritica==1))(12, 10, 12) */
		reached[0][10] = 1;
		spin_assert((now.enSeccionCritica==1), "(enSeccionCritica==1)", II, tt, t);
		_m = 3; goto P999; /* 3 */
	case 30: // STATE 12 - modelo_sincronizacion.pml:65 - [cambiosTotales = (cambiosTotales+cambiosLocal)] (0:0:1 - 1)
		IfNotBlocked
		reached[0][12] = 1;
		(trpt+1)->bup.oval = now.cambiosTotales;
		now.cambiosTotales = (now.cambiosTotales+((P0 *)_this)->cambiosLocal);
#ifdef VAR_RANGES
		logval("cambiosTotales", now.cambiosTotales);
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 31: // STATE 13 - modelo_sincronizacion.pml:72 - [enSeccionCritica = (enSeccionCritica-1)] (0:17:2 - 1)
		IfNotBlocked
		reached[0][13] = 1;
		(trpt+1)->bup.ovals = grab_ints(2);
		(trpt+1)->bup.ovals[0] = now.enSeccionCritica;
		now.enSeccionCritica = (now.enSeccionCritica-1);
#ifdef VAR_RANGES
		logval("enSeccionCritica", now.enSeccionCritica);
#endif
		;
		/* merge: mutex = 0(17, 14, 17) */
		reached[0][14] = 1;
		(trpt+1)->bup.ovals[1] = ((int)now.mutex);
		now.mutex = 0;
#ifdef VAR_RANGES
		logval("mutex", ((int)now.mutex));
#endif
		;
		_m = 3; goto P999; /* 1 */
	case 32: // STATE 16 - modelo_sincronizacion.pml:82 - [sumaControl = (sumaControl+cambiosLocal)] (0:0:1 - 1)
		IfNotBlocked
		reached[0][16] = 1;
		(trpt+1)->bup.oval = now.sumaControl;
		now.sumaControl = (now.sumaControl+((P0 *)_this)->cambiosLocal);
#ifdef VAR_RANGES
		logval("sumaControl", now.sumaControl);
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 33: // STATE 18 - modelo_sincronizacion.pml:90 - [workersTerminados = (workersTerminados+1)] (0:21:1 - 1)
		IfNotBlocked
		reached[0][18] = 1;
		(trpt+1)->bup.oval = now.workersTerminados;
		now.workersTerminados = (now.workersTerminados+1);
#ifdef VAR_RANGES
		logval("workersTerminados", now.workersTerminados);
#endif
		;
		/* merge: printf('Worker %d termino\\n',id)(21, 20, 21) */
		reached[0][20] = 1;
		Printf("Worker %d termino\n", ((P0 *)_this)->id);
		_m = 3; goto P999; /* 1 */
	case 34: // STATE 21 - modelo_sincronizacion.pml:94 - [-end-] (0:0:0 - 1)
		IfNotBlocked
		reached[0][21] = 1;
		if (!delproc(1, II)) continue;
		_m = 3; goto P999; /* 0 */
	case  _T5:	/* np_ */
		if (!((!(trpt->o_pm&4) && !(trpt->tau&128))))
			continue;
		/* else fall through */
	case  _T2:	/* true */
		_m = 3; goto P999;
#undef rand
	}

