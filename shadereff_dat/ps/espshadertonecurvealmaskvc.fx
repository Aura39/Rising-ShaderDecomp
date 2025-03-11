float4 g_Rate : register(c185);
sampler g_Sampler0 : register(s0);
sampler g_Sampler1 : register(s1);

struct PS_IN
{
	float2 texcoord : TEXCOORD;
	float2 texcoord1 : TEXCOORD1;
	float4 texcoord7 : TEXCOORD7;
};

float4 main(PS_IN i) : COLOR
{
	float4 o;

	float4 r0;
	float4 r1;
	float4 r2;
	r0 = tex2D(g_Sampler1, i.texcoord1);
	r1 = tex2D(g_Sampler0, i.texcoord);
	r2 = r1.w * r0.w + -0.0001;
	r0.w = r0.w * r1.w;
	r0.xyz = g_Rate.yyy * r1.xyz + g_Rate.xxx;
	o = r0 * i.texcoord7;
	clip(r2);

	return o;
}
