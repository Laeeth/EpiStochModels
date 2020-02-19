///
module register;

version(SIL):

import kaleidic.sil.lang.handlers:Handlers;
import kaleidic.sil.lang.types : Variable,Function,SILdoc;
import std.meta:AliasSeq;

version (SIL_Plugin)
{
	import kaleidic.sil.lang.plugin : pluginImpl;
	mixin pluginImpl!registerEpidemic;
}


///
void registerEpidemic(ref Handlers handlers)
{
	import models;
	import multinomial;
	import std.meta : AliasSeq;
	import std.typecons: Tuple;
	handlers.openModule("epidemic");
	scope(exit) handlers.closeModule();
	static foreach(T; AliasSeq!(SIR, SIR_Dem, Influenza))
			handlers.registerType!T;
	handlers.registerType!(Tuple!(double[], uint[], uint[], double[]));
	handlers.registerHandler!multinomialVar;
}

