float4 g_BlendRate : register(c185);
sampler g_Sampler0 : register(s0);
sampler g_Sampler1 : register(s1);
sampler g_Sampler2 : register(s2);

struct PS_IN
{
	float2 texcoord : TEXCOORD;
	float2 texcoord1 : TEXCOORD1;
	float4 texcoord2 : TEXCOORD2;
};

float4 main(PS_IN i) : COLOR
{
	float4 o;

	float4 r0;
	float4 r1;
	float4 r2;
	r0 = tex2D(g_Sampler1, i.texcoord1);
	r1 = r0.w + -0.001;
	clip(r1);
	r1 = tex2D(g_Sampler0, i.texcoord);
	r2 = tex2D(g_Sampler2, i.texcoord);
	r0.xyz = lerp(r2.xyz, r1.xyz, g_BlendRate.xxx);
	o = r0 * i.texcoord2;

	return o;
}
