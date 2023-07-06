float4 g_BlendRate;
float4 g_Rate;
sampler g_Sampler0;
sampler g_Sampler1;
sampler g_Sampler2;

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
	r0 = tex2D(g_Sampler0, i.texcoord);
	r1 = tex2D(g_Sampler2, i.texcoord);
	r2 = lerp(r1, r0, g_BlendRate.x);
	r0 = tex2D(g_Sampler1, i.texcoord1);
	r0.w = r0.w * r2.w;
	r0.xyz = r2.xyz * g_Rate.yyy + g_Rate.xxx;
	o = r0 * i.texcoord2;

	return o;
}
