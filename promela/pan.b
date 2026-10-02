	switch (t->back) {
	default: Uerror("bad return move");
	case  0: goto R999; /* nothing to undo */

		 /* PROC Main */
;
		;
		
	case 4: // STATE 2
		;
		now.cambiosTotales = trpt->bup.oval;
		;
		goto R999;

	case 5: // STATE 3
		;
		now.sumaControl = trpt->bup.oval;
		;
		goto R999;

	case 6: // STATE 4
		;
		now.workersTerminados = trpt->bup.oval;
		;
		goto R999;

	case 7: // STATE 5
		;
		((P1 *)_this)->i = trpt->bup.oval;
		;
		goto R999;
;
		;
		
	case 9: // STATE 7
		;
		;
		delproc(0, now._nr_pr-1);
		;
		goto R999;

	case 10: // STATE 8
		;
		((P1 *)_this)->i = trpt->bup.oval;
		;
		goto R999;

	case 11: // STATE 9
		;
	/* 0 */	((P1 *)_this)->i = trpt->bup.oval;
		;
		;
		goto R999;
;
		;
		;
		;
		;
		;
		;
		
	case 15: // STATE 17
		goto R999;

	case 16: // STATE 23
		;
		((P1 *)_this)->iter = trpt->bup.oval;
		;
		goto R999;

	case 17: // STATE 23
		;
		((P1 *)_this)->iter = trpt->bup.oval;
		;
		goto R999;

	case 18: // STATE 24
		;
	/* 0 */	((P1 *)_this)->iter = trpt->bup.oval;
		;
		;
		goto R999;
;
		
	case 19: // STATE 29
		goto R999;

	case 20: // STATE 31
		;
		p_restor(II);
		;
		;
		goto R999;

		 /* PROC Worker */

	case 21: // STATE 1
		;
		((P0 *)_this)->cambiosLocal = trpt->bup.oval;
		;
		goto R999;

	case 22: // STATE 2
		;
		((P0 *)_this)->cambiosLocal = trpt->bup.oval;
		;
		goto R999;

	case 23: // STATE 3
		;
		((P0 *)_this)->cambiosLocal = trpt->bup.oval;
		;
		goto R999;
;
		
	case 24: // STATE 6
		goto R999;

	case 25: // STATE 9
		;
		now.enSeccionCritica = trpt->bup.ovals[1];
		now.mutex = trpt->bup.ovals[0];
		;
		ungrab_ints(trpt->bup.ovals, 2);
		goto R999;

	case 26: // STATE 12
		;
		now.cambiosTotales = trpt->bup.oval;
		;
		goto R999;

	case 27: // STATE 14
		;
		now.mutex = trpt->bup.ovals[1];
		now.enSeccionCritica = trpt->bup.ovals[0];
		;
		ungrab_ints(trpt->bup.ovals, 2);
		goto R999;

	case 28: // STATE 16
		;
		now.sumaControl = trpt->bup.oval;
		;
		goto R999;

	case 29: // STATE 18
		;
		now.workersTerminados = trpt->bup.oval;
		;
		goto R999;

	case 30: // STATE 21
		;
		p_restor(II);
		;
		;
		goto R999;
	}

