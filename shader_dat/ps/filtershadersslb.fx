float4 g_LightPosVP;
sampler g_Sampler0;
float4 g_SslbParam;
float4 g_TargetUvParam;

float4 main(float2 texcoord : TEXCOORD) : COLOR
{
	float4 o;

	float4 r0;
	float4 r1;
	float4 r2;
	float2 r3;
	float4 r4;
	r0.xy = g_TargetUvParam.xy + texcoord.xy;
	r0.zw = r0.xy + -g_LightPosVP.xy;
	r0.zw = r0.zw * g_LightPosVP.zz;
	r1 = tex2D(g_Sampler0, r0);
	r2 = r1;
	r3.xy = r0.xy;
	for (int i0 = 0; i0 < 31; i0++) {
		r3.xy = r0.zw * -0.032258064 + r3.xy;
		r4 = tex2D(g_Sampler0, r3);
		r2 = r2 + r4;
	}
	r0.xyz = r2.xyz * g_LightPosVP.www;
	r1.x = r1.w * g_SslbParam.x;
	r0.w = r2.w * 0.0390625 + r1.x;
	r1.w = g_LightPosVP.w;
	r1 = r1.w * float4(0, 0, 0, 1) + float4(0.03125, 0.03125, 0.03125, 0);
	o = r0 * r1;

	return o;
}
