sampler Shadow_Tex_sampler;
sampler g_Sampler0;

struct PS_IN
{
	float3 texcoord : TEXCOORD;
	float4 texcoord1 : TEXCOORD1;
	float4 texcoord2 : TEXCOORD2;
	float4 texcoord3 : TEXCOORD3;
	float2 texcoord4 : TEXCOORD4;
};

float4 main(PS_IN i) : COLOR
{
	float4 o;

	float4 r0;
	float4 r1;
	float4 r2;
	float4 r3;
	r0 = tex2D(g_Sampler0, i.texcoord4);
	r0 = r0.w + -0.5;
	clip(r0);
	r0.x = 1 / i.texcoord1.w;
	r0.y = i.texcoord1.x * r0.x + 1;
	r0.y = r0.y * 0.5 + -0.019511718;
	r0.zw = r0.xx * i.texcoord1.xy;
	r0.x = i.texcoord1.y * -r0.x + 1;
	r0.x = r0.x * 0.5 + -0.019305555;
	r0.xy = (r0.xy >= 0) ? 0 : 1;
	r0.zw = r0.zw * float2(-0.5, 1) + 0.5;
	r0.zw = r0.zw + float2(0.00048828125, 0.00069444446);
	r1.xy = -r0.zw + 0.98;
	r0.zw = r0.zw * 0.5;
	r1.xy = (r1.xy >= 0) ? 0 : 1;
	r0.y = r0.y + r1.x;
	r0.y = (-r0.y >= 0) ? 0 : 1;
	r0.x = r0.x + r0.y;
	r0.x = (-r0.x >= 0) ? 0 : 1;
	r0.x = r1.y + r0.x;
	r0.y = 1 / i.texcoord2.w;
	r1.xy = r0.yy * i.texcoord2.xy;
	r0.y = i.texcoord2.y * -r0.y + 1;
	r0.y = r0.y * 0.5 + -0.019305555;
	r1.xy = r1.xy * float2(0.5, -0.5) + 0.5;
	r1.xy = r1.xy + float2(0.00048828125, 0.00069444446);
	r2.y = r1.y * 0.5;
	r2.z = r1.x * 0.5 + 0.5;
	r2.zw = (-r0.xx >= 0) ? r0.zw : r2.zy;
	r0.xz = r1.xx * 0.5 + float2(0.5, 1);
	r0.w = -r1.y + 0.98;
	r0.x = -r0.x + 0.99;
	r0 = (r0 >= 0) ? 0 : 1;
	r0.x = r0.x + r0.z;
	r0.x = (-r0.x >= 0) ? 0 : 1;
	r0.x = r0.y + r0.x;
	r0.x = (-r0.x >= 0) ? 0 : 1;
	r0.x = r0.w + r0.x;
	r0.y = 1 + -i.texcoord1.z;
	r2.xy = r0.yy + float2(0.00125, 0.0025);
	r1.z = r2.y;
	r0.y = 1 / i.texcoord3.w;
	r0.yz = r0.yy * i.texcoord3.xy;
	r0.yz = r0.yz * float2(-0.5, 0.5) + 0.5;
	r0.yz = r0.yz + 0.00048828125;
	r1.x = r0.y * 0.5;
	r1.w = r0.z * 0.5 + 0.5;
	r1.xyz = (-r0.xxx >= 0) ? r2.xzw : r1.zxw;
	r2 = r1.yzyz + float4(0.0009765625, 0, -0.0009765625, 0);
	r3 = tex2D(Shadow_Tex_sampler, r2);
	r2 = tex2D(Shadow_Tex_sampler, r2.zwzw);
	r0.x = -r1.x + r2.x;
	r0.w = -r1.x + r3.x;
	r0.xw = (r0.xw >= 0) ? 0.25 : 0;
	r0.x = r0.x + r0.w;
	r2 = r1.yzyz + float4(0, 0.0013888889, 0, -0.0013888889);
	r3 = tex2D(Shadow_Tex_sampler, r2);
	r2 = tex2D(Shadow_Tex_sampler, r2.zwzw);
	r0.w = -r1.x + r2.x;
	r1.x = -r1.x + r3.x;
	r1.x = (r1.x >= 0) ? 0.25 : 0;
	r0.x = r0.x + r1.x;
	r0.w = (r0.w >= 0) ? 0.25 : 0;
	r0.x = r0.w + r0.x;
	r0.zw = r0.zz * 0.5 + float2(0.00048828125, 0.00069444446);
	r0.z = -r0.z + 0.501;
	r0.w = (r0.w >= 0) ? -0 : -1;
	r0.z = (r0.z >= 0) ? -0 : r0.w;
	r0.w = r0.y + -0.998;
	r0.y = -r0.y + 0.002;
	r0.z = (r0.w >= 0) ? -0 : r0.z;
	r0.y = (r0.y >= 0) ? -0 : r0.z;
	r0.x = (r0.y >= 0) ? 0 : r0.x;
	o.xyz = (i.texcoord.zzz >= 0) ? r0.xxx : 1;
	o.w = 1;

	return o;
}
