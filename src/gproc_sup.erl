%%%----------------------------------------------------------------------
%%% File    : gproc_sup.erl
%%% Purpose : GPROC top-level supervisor
%%%----------------------------------------------------------------------

-module(gproc_sup).

-behaviour(supervisor).

%% External exports
-export([start_link/1]).

%% supervisor callbacks
-export([init/1]).

%%%----------------------------------------------------------------------
%%% API
%%%----------------------------------------------------------------------
start_link(Args) ->
    supervisor:start_link({local, ?MODULE}, ?MODULE, Args).

%%%----------------------------------------------------------------------
%%% Callback functions from supervisor
%%%----------------------------------------------------------------------

%%----------------------------------------------------------------------
%% Func: init/1
%% Returns: {ok,  {SupFlags,  [ChildSpec]}} |
%%          ignore                          |
%%          {error, Reason}
%%----------------------------------------------------------------------
%% @spec(_Args::term()) -> {ok, {supervisor_flags(), child_spec_list()}}
%% @doc The main GPROC supervisor.

init(_Args) ->
    %% Hint:
    %% Child_spec = [Name, {M, F, A},
    %%               Restart, Shutdown_time, Type, Modules_used]

    GProc =
        {gproc, {gproc, start_link, []},
         permanent, 2000, worker, [gproc]},

    Dist = case application:get_env(gproc_dist) of
               undefined -> [];
               {ok, false} -> [];
               {ok, Env} ->
                   case Env of
                       [Nodes, Opts] when is_list(Nodes), is_list(Opts) ->
                           Arg = {Nodes,Opts};
                       Other ->
                           Arg = Other
                   end,
                   [{gproc_dist, {gproc_dist, start_link, [Arg]},
                     permanent, 2000, worker, [gproc_dist]}]
           end,
    {ok,{{one_for_one, 15, 60}, [GProc | Dist]}}.


%%%----------------------------------------------------------------------
%%% Internal functions
%%%----------------------------------------------------------------------
