sampler g_AmbientSampler : register(s0);
sampler g_LightSampler : register(s1);
float4 g_MatrialColor : register(c185);
sampler g_ZSampler : register(s2);
float3 g_fogCol : register(c190);
float4 g_fogParam : register(c191);
float4 g_preFogEnhanceColor : register(c184);

float4 main(float2 texcoord : TEXCOORD) : COLOR
{
	float4 o;

	float4 r0;
	float4 r1;
	float4 r2;
	r0 = tex2D(g_ZSampler, texcoord);
	r0.x = g_fogParam.w * -r0.x + g_fogParam.x;
	r1 = tex2D(g_LightSampler, texcoord);
	r2 = tex2D(g_AmbientSampler, texcoord);
	r0.yzw = r2.xyz * g_preFogEnhanceColor.xyz + r1.xyz;
	o.w = r2.w;
	r1.xyz = g_fogCol.xyz;
	r0.yzw = r0.yzw * g_MatrialColor.xyz + -r1.xyz;
	o.xyz = r0.xxx * r0.yzw + g_fogCol.xyz;

	return o;
}
