sampler g_Sampler0 : register(s13);

struct PS_IN
{
	float2 texcoord : TEXCOORD;
	float4 texcoord1 : TEXCOORD1;
	float4 texcoord2 : TEXCOORD2;
	float2 texcoord3 : TEXCOORD3;
};

float4 main(PS_IN i) : COLOR
{
	float4 o;

	float4 r0;
	float4 r1;
	float r2;
	r0.x = 1 / i.texcoord3.x;
	r0.yz = -0.5 + i.texcoord.xy;
	r0.yz = r0.yz + r0.yz;
	r1.x = pow(abs(r0.z), i.texcoord2.z);
	r0.x = r0.x * r1.x;
	r0.zw = r0.yz * i.texcoord2.xy;
	r1.x = pow(abs(r0.y), i.texcoord2.w);
	r0.x = r0.z * -r0.x + i.texcoord.x;
	r0.z = 1 / i.texcoord3.y;
	r0.z = r0.z * r1.x;
	r0.y = r0.w * -r0.z + i.texcoord.y;
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
