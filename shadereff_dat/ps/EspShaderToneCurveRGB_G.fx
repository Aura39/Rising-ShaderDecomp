float4 g_Rate;
sampler g_Sampler0;

struct PS_IN
{
	float2 texcoord : TEXCOORD;
	float4 texcoord1 : TEXCOORD1;
};

float4 main(PS_IN i) : COLOR
{
	float4 o;

	float4 r0;
	r0 = tex2D(g_Sampler0, i.texcoord);
	r0.xyz = r0.xyz * g_Rate.yyy + g_Rate.xxx;
	o = r0 * i.texcoord1;

	return o;
}
