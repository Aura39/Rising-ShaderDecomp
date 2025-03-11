sampler g_Sampler0 : register(s13);

struct PS_IN
{
	float2 texcoord : TEXCOORD;
	float4 texcoord1 : TEXCOORD1;
	float2 texcoord2 : TEXCOORD2;
};

float4 main(PS_IN i) : COLOR
{
	float4 o;

	float4 r0;
	float4 r1;
	float r2;
	r0.xy = -0.5 + i.texcoord.xy;
	r0.xy = r0.xy + r0.xy;
	r0.zw = abs(r0.yx) * i.texcoord2.xy;
	r0.xy = r0.xy * -r0.zw + i.texcoord.xy;
	r0 = tex2D(g_Sampler0, r0);
	r0.xyz = -r0.xyz + 1;
	r1.x = min(r0.y, r0.x);
	r2.x = min(r0.z, r1.x);
	r0.xyz = r0.xyz + -r2.xxx;
	r1.w = -r2.x + 1;
	r0.w = 1 / r1.w;
	r0.xyz = r0.xyz * -r0.www + 1;
	r1.xyz = max(r0.xyz, 0);
	o = r1 * i.texcoord1;

	return o;
}
