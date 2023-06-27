float4 g_BokeRate;
sampler g_Sampler0;
sampler g_Sampler1;
float4 g_TargetUvParam;

struct PS_OUT
{
	float4 color : COLOR;
	float4 color1 : COLOR1;
};

PS_OUT main(float2 texcoord : TEXCOORD)
{
	PS_OUT o;

	float4 r0;
	float4 r1;
	float4 r2;
	float4 r3;
	r0 = tex2D(g_Sampler1, texcoord);
	r0.x = r0.x * g_BokeRate.x;
	r0.y = 0;
	r1 = 0;
	for (int i0 = 0; i0 < 32; i0++) {
		r0.zw = r0.yy * g_TargetUvParam.xy;
		r0.zw = r0.xx * r0.zw;
		r2.x = r0.z * -0.9000159 + texcoord.x;
		r2.y = r0.w * -0.4358571 + texcoord.y;
		r3 = tex2D(g_Sampler1, r2);
		r0.z = (-r3.x >= 0) ? 0 : 1;
		r0.w = (-r0.y >= 0) ? 1 : 0;
		r0.z = r0.w + r0.z;
		r2 = tex2D(g_Sampler0, r2);
		r2.xyz = r1.xyz + r2.xyz;
		r2.w = r1.w + 1;
		r1 = (-r0.z >= 0) ? r1 : r2;
		r0.y = r0.y + 1;
	}
	r0.y = 1 / r1.w;
	o.color.xyz = r0.yyy * r1.xyz;
	r0.y = 0;
	r1 = 0;
	for (int i0 = 0; i0 < 32; i0++) {
		r0.zw = r0.yy * g_TargetUvParam.xy;
		r0.zw = r0.xx * r0.zw;
		r0.zw = r0.zw * -0 + texcoord.xy;
		r2 = tex2D(g_Sampler1, r0.zwzw);
		r2.x = (-r2.x >= 0) ? 0 : 1;
		r2.y = (-r0.y >= 0) ? 1 : 0;
		r2.x = r2.y + r2.x;
		r3 = tex2D(g_Sampler0, r0.zwzw);
		r3.xyz = r1.xyz + r3.xyz;
		r3.w = r1.w + 1;
		r1 = (-r2.x >= 0) ? r1 : r3;
		r0.y = r0.y + 1;
	}
	r0.y = 1 / r1.w;
	o.color1.xyz = r0.yyy * r1.xyz;
	r0.x = r0.x + r0.x;
	o.color.w = r0.x;
	o.color1.w = r0.x;

	return o;
}
