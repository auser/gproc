%%% -*- mode: erlang -*-
%%% $Id$
%%%

{application, gproc,
 [
  {description, "GPROC"},
  {vsn, "0.01"},
  {id, "GPROC"},
  {modules, [
	     %% TODO: fill in this list, perhaps
	     gen_leader, gproc, gproc_app, gproc_dist, gproc_init, gproc_lib, gproc_sup
            ]
  },
  {registered, [ ] },
  %% NOTE: do not list applications which are load-only!
  {applications, [ kernel, stdlib ] },
  {mod, {gproc_app, []} }
 ]
}.
