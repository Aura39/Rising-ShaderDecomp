sampler g_Sampler0 : register(s0);
sampler g_Sampler1 : register(s1);
float4 g_TargetUvParam : register(c194);
float4 g_offsetPow : register(c184);

float4 main(float2 texcoord : TEXCOORD) : COLOR
{
	float4 o;

	float4 r0;
	float4 r1;
	float r2;
	r0.xy = g_TargetUvParam.xy + texcoord.xy;
	r1 = tex2D(g_Sampler1, r0);
	r0 = tex2D(g_Sampler0, r0);
	r2.x = pow(r1.x, g_offsetPow.w);
	o = r0 * r2.x;

	return o;
}
