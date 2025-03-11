float4 g_Rate : register(c185);
sampler g_Sampler0 : register(s0);
sampler g_Sampler1 : register(s1);

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
	r0 = tex2D(g_Sampler1, i.texcoord1);
	r0.w = r0.w * g_Rate.w + g_Rate.z;
	r1 = tex2D(g_Sampler0, i.texcoord);
	r0.xyz = r1.xyz;
	o = r0 * i.texcoord2;

	return o;
}
