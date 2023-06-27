sampler g_Sampler;

struct PS_IN
{
	float2 texcoord : TEXCOORD;
	float vface : vFace;
};

float4 main(PS_IN i) : COLOR
{
	float4 o;

	float2 r0;
	r0.x = 0.5 * vFace.x;
	r0.x = frac(r0.x);
	r0.x = i.texcoord.y * 0.5 + -r0.x;
	r0.y = r0.x + 0.5;
	r0.x = i.texcoord.x;
	o = tex2D(g_Sampler, r0);

	return o;
}
